import java.util.*;

/**
 * An example class.
 *
 * @author Dawid Weiss
 */
public final class Example {
	/**
	 * Command line entry point.
	 */
	public static void main(String [] args) {
		if (args.length == 0) {
			System.out.println("Hello world.");
		} else {
			System.out.println(Arrays.asList(args[0]));
		}
	}
}