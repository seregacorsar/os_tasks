import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class os_task2 {

	static ArrayList<Integer> numbers = new ArrayList<Integer>();
	
	public static void main(String[] args) {
		
		String fins = "";
		try {
			for ( String fin : args )
				fins += readFromFile(fin);
		} catch (OutOfMemoryError e) {
			e.printStackTrace();
		}
			
		System.out.println(fins);
		String[] ololo = fins.split(" ");
		Pattern pat = Pattern.compile("^\\d+$");
		for (int i=0; i < ololo.length; ++i) {
			Matcher matcher = pat.matcher(ololo[i]);
			if (matcher.find())
				numbers.add(Integer.parseInt(matcher.group()));
		}

		try {
			Collections.sort(numbers);
		} catch (OutOfMemoryError e) {
			e.printStackTrace();
		}
		
		String res = "";
		for (int i=0; i < numbers.size(); ++i) {
			res += numbers.get(i).toString() + ' ';
		}
		writeToFile(res);
	
	}
	
	@SuppressWarnings("deprecation")
	static String readFromFile(String filename) {
		
	    FileInputStream fis = null;
	    BufferedInputStream bis = null;
	    DataInputStream dis = null;
	    try {
			fis = new FileInputStream(new File(filename));
			bis = new BufferedInputStream(fis);
			dis = new DataInputStream(bis);
			while (dis.available() != 0) {
				return dis.readLine();
			}
			fis.close();
			bis.close();
			dis.close();
	    } catch (FileNotFoundException e) {
			e.printStackTrace();
	    } catch (IOException e) {
	    	e.printStackTrace();
	    }
	    return null;
	
	}
	
	static void writeToFile(String str) {
		
		PrintWriter pw = null;
	    try {
			pw = new PrintWriter(new FileOutputStream("out"));
			pw.write(str);
	    } catch (IOException e) {
	    	e.printStackTrace();
	    } finally {
	    	pw.close();
	    }
	
	}

}
