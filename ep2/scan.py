#!/usr/bin/python
import sys
import re
import os
import lxml
import xml.etree.ElementTree as ET
from lxml import etree # pretty_print
__author__ = 'TaQini'

# keyword in C
keyword = ['auto', 'break', 'case', 'char', 'const', 'continue', 'default',
			'do', 'double', 'else', 'enum', 'extern', 'float', 'for', 'goto',
			'if', 'int', 'long', 'register', 'return', 'short', 'signed', 'sizeof',
			'static', 'struct', 'switch', 'typedef', 'union', 'unsigned', 'void',
			'volatile', 'while', '_Alignas', '_Alignof', '_Atomic', '_Bool', 
			'_Complex', '_Generic', '_Imaginary', '_Noreturn', '_Static_assert',
			'_Therad_local']

# separator and operator in C
sep_op = ['[', ']', '(', ')', '{', '}', '.', '->', '++', '--', '&', '*', 
			'+', '-', '~', '!', '/', '%', '<<', '>>', '<', '>', '<=', '>=',
			'==', '!=', '^', '|', '&&', '||', '?', ':', ';', '...', '=', 
			'*=', '/=', '%=', '+=', '-=', '<<=', '>>=', '&=', '^=', '|=',
			',', '#', '##', '<:', ':>', '<%', '%>', '%:', '%:%:']

def main():
	pair = input()
	res = []
	for i in range(len(pair)):
		num = i+1
		val, lne = pair[i]
		typ, vld = resolve(val)
		res.append([num, val, typ, lne, vld])
	output(res)

# check whether matching completely
def check(rec, val):
	if len(rec.findall(val)) and len(rec.findall(val)[0]) == len(val):
		return True
	else:
		return False

# exclude some wrong match
def exclude(rec, val):
	if len(rec.findall(val)):
		return False
	else:
		return True

# recognize vocabulary
def resolve(val):
	# match keyword
	if val in keyword:
		return ('keyword',True)
	else:
		# match identifer
		identifer = re.compile('[_a-zA-Z][_a-zA-Z0-9]*')
		if check(identifer, val):
			return ('identifer', True)
		else:
			# match integer constant
			dec_constant = re.compile('[1-9][0-9]*[u|U]?[l|L]{0,2}[u|U]?') # 123ulLU also accept :-P
			oct_constant = re.compile('0[0-7]*[u|U]?[l|L]{0,2}[u|U]?')
			hex_constant = re.compile('0[x|X][a-fA-F0-9]+[u|U]?[l|L]{0,2}[u|U]?')
			exclude_lL   = re.compile('lL|Ll|[u|U].*[u|U]') # exclude e.g. Ll, uLLU, ... 
			if (check(dec_constant, val) or check(oct_constant, val) or 
				check(hex_constant, val)) and exclude(exclude_lL, val):
				return ('constant_int', True)
			else:
				# match floating constant
				dec_flt_constant = re.compile(
						'[0-9]*\.[0-9]+[e|E][+|-]?[0-9]+[f|l|F|L]?'	# dec -> fra exp suffix(opt)
						'|[0-9]+\.[e|E][+|-]?[0-9]+[f|l|F|L]?'
						'|[0-9]*\.[0-9]+[f|l|F|L]?'					# dec -> fra suffix(opt)
						'|[0-9]+\.[f|l|F|L]?'
						'|[0-9]+[e|E][+|-]?[0-9]+[f|l|F|L]?')		# dec -> dig exp suffix(opt)
				hex_flt_constant = re.compile(
						'0x[0-9a-f]*\.[0-9a-f]+p[+|-]?[0-9]+[f|l]?'	# hex -> 0x fra exp suffix(opt)
						'|0x[0-9a-f]+\.p[+|-]?[0-9]+[f|l]?'
						'|0x[0-9a-f]+p[+|-]?[0-9]+[f|l]?',			# hex -> dig exp suffix(opt)
						re.I)										# Ignore case
				if check(dec_flt_constant, val) or check(hex_flt_constant, val):
					return ('constant_float', True)
				else:
					# match character constant
					char_constant = re.compile("[L|u|U]?\'[^\\\']+\'") # interesting :)
					if check(char_constant, val):
						return ('constant_char', True)
					else:
						# match string constant
						string_constant = re.compile('[L|u|U]?\"[^\\\"]*\"|u8\"[^\\\"]*\"')
						if check(string_constant, val):
							return ('constant_string', True)
						else:
							# match separator or operator
							if val in sep_op:
								return ('sep/operator', True)
							else:
								# other vocabulary -> WRONG!
								return ('unknown', False)

def input():
	f = open(sys.argv[1], 'ro')
	data = f.readlines()
	f.close()
	pair = []
	for line in range(len(data)):
		for value in data[line].split():
			pair.append([value, line+1])
	return pair

def output(res):
	new_xml = ET.Element("project",attrib={"name":sys.argv[1]})
	tokens =  ET.SubElement(new_xml,"tokens")
	res.append([len(res)+1, '#', '#', res[-1][3]+1, True]) # add # to the end ...
	# mapping each item and formating to xml 
	for i in res:
		token = ET.SubElement(tokens,"token")
		number = ET.SubElement(token,"number")
		number.text = str(i[0])
		value = ET.SubElement(token,"value")
		value.text = i[1]
		type_ = ET.SubElement(token,"type")
		type_.text = i[2]
		line = ET.SubElement(token,"line")
		line.text = str(i[3])
		valid = ET.SubElement(token,"valid")
		valid.text = str(i[4])
	et = ET.ElementTree(new_xml)
	tmp = ET.tostring(et.getroot())
	root = etree.fromstring(tmp)
	res = etree.tostring(root, pretty_print=True)
	# output to file
	f = open(sys.argv[2], 'w+')
	f.write('<?xml version="1.0" encoding="UTF-8"?>\n')
	f.write(res)
	f.close()

if __name__ == "__main__":
	main()
