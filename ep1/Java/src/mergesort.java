import java.io.*;

public class mergesort
{
	void Merge(int tmp[], int a[], int lena, int d[], int lend) {
		int pa, pd, pt;
		pa = 0; pd = 0; pt = 0;
		while( pa < lena && pd < lend) {
		if( a[pa] < d[pd]) tmp[pt++] = a[pa++];
		else tmp[pt++] = d[pd++];
		}
		while(pa < lena) tmp[pt++] = a[pa++];
		while(pd < lend) tmp[pt++] = d[pd++];
	}

    void MergeSort(int l[], int n) {
		int m, i, a[], d[];
		if(n < 2) return;
		m = n/2;
		a = new int[m];
		d = new int[n-m];
		for(i = 0; i < m; i++) a[i] = l[i];
		for(i = m; i < n; i++) d[i-m] = l[i];
		MergeSort(a, m);
		MergeSort(d, n-m);
		Merge(l, a, m, d, n-m);
	}

    public static void main(String args[]) {
		// input data
		String fileName = "./raw.dat";
		int n = 1000000;
		int l[] = new int[n];
		int i = 0;
		String line = null;
		try {
			FileReader fileReader = new FileReader(fileName);
			BufferedReader bufferedReader = new BufferedReader(fileReader);
            while((line = bufferedReader.readLine()) != null) {
				l[i] = Integer.parseInt(line);
				i++;
			}
		}
        catch(FileNotFoundException ex) {
			System.out.println("Unable to open file '" + fileName + "'");
		}
		catch(IOException ex) {
			System.out.println("Error reading file '" + fileName + "'");
		}
		
		mergesort obj = new mergesort();
		// get time
		long begin = System.currentTimeMillis();
		
		obj.MergeSort(l, n);

		long end = System.currentTimeMillis();
		double last = end - begin;
		last /= 1000.0;
		System.out.println(String.format("cost: %fs", last));
		/*
		// output to file
		fileName = "result.java.dat";
		try {
			FileWriter fileWriter = new FileWriter(fileName);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			for(i = 0; i < n; i++){
				bufferedWriter.write(Integer.toString(l[i]) + "\n");
			}
			
			bufferedWriter.close();
        }
		catch(IOException ex) {
			System.out.println("Error writing to file '"+ fileName + "'"); 
        }
		*/
    }
}


















