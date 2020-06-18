import java.util.Random;

public class main {
    public static String uploadNewBook(String Bi,String Bn,String Ban,String Bc,String Bsc,String Bp) {
        try {
            // Bi is Book Image path
            // Bn is Book Name
            // Ban is Book Author name
            // Bc is Book Category
            // Bsc is Book Sub category
            // Bp is Book Price
            /*
             * Image image = new ImageIcon(this.getClass().getResource(Bi)).getImage();
             * If you're a java dev, you can uncomment this and convert image path to a real path
             */
            // Delete Special Chars
            Bn = Bn.replaceAll("[-.\\+*?\\[^\\]$(){}=!<>|:\\\\]", "");
            Ban = Ban.replaceAll("[-.\\+*?\\[^\\]$(){}=!<>|:\\\\]", "");
            Bc = Bc.replaceAll("[-.\\+*?\\[^\\]$(){}=!<>|:\\\\]", "");
            Bsc = Bsc.replaceAll("[-.\\+*?\\[^\\]$(){}=!<>|:\\\\]", "");
            Bp = Bp.replaceAll("[-.\\+*?\\[^\\]$(){}=!<>|:\\\\]", "");
            String Bid = getSaltString();
            // TODO: Insert data command + Bid
            return Bid; // Book ID return
        }catch(Exception e) {
            return e.getMessage(); // if there's some kind of error
            }
        }
    public static int calculateAverageRating(String Bid) {
        try {
            String ratings = "";
            // TODO: Retreive Ratings and put it in [ratings]
            // Ratings SHOULD be an integer, 2 is right while 2.1 is wrong.
            // ratings will be in form of r1,r2,r3,...
            String[] rArray = ratings.split(",");
                int[] numbers = new int[rArray.length]; // Ratings will be converted from {String} to {integer}
                for(int i = 0;i < rArray.length;i++) {
                   numbers[i] = Integer.parseInt(rArray[i]); // Conversion Process
                }
                int wNumber = 0; // Assigned 0 to [wNumber] so we won't get errors
                for(int x = 0;x < numbers.length;x++) {
                    wNumber = wNumber + numbers[x]; // Add numbers process
                    }
                int aNumber = wNumber / numbers.length; // Average Rating
                return aNumber;
        }catch(Exception e) {
            return -1; // if there's some kind of error
            }
        }
    public static String retrieveBookData(String Bid) {
        try {
            // TODO: Send Bid, receive Data in form of Bn,Bp,Ban,Bc,Bsc, calculateAverageRating(Bid);
            // put TODO in {String}
            String data = "";
            return data;
        }catch(Exception e) {
            return e.getMessage(); // if there's some kind of error
            }
        }
    public static String searchBook(String query) {
        try {
        // TODO: send [query] and retrieve Bid[s] in form of Bid1,Bid2,Bid3,...
        // put TODO in {String}
        String results = "";
        return results;
        // App will use results.split(","); and use retrieve Book Data and also split it and distribute it to TextView
        }catch(Exception e) {
            return e.getMessage(); // if there's some kind of error
            }
    }
    public static String saveBooksBookmark(String Bid) {
        try {
        // TODO: insert [Bid] to User's table of Bookmarks
        return "Done"; // Confirm it's added
        }catch(Exception e) {
            return e.getMessage(); // if there's some kind of error
            }
        // You can retrieve it again by using retrieveBookData(Bid); and split and distribute to TextView
        }
    public static String sendFeedback(String Bid,String feedback) {
        try {
            // TODO: send feedback
            return "Done";
        }catch(Exception e) {
            return e.getMessage(); // if there's some kind of error
            }
        }
    public static String retrieveFeedbacks(String Bid) {
        try {
            // TODO: retreive feedbacks in form of user,feedback|user,feedback|...
            // Use split of | then , and distribute to TextView and store it to [result]
            String result = "";
            return result;
        }catch(Exception e) {
           return e.getMessage(); // if there's some kind of error
            }
        }
    public static String getSaltString() {
        // Malaksh da3wah bel elbeta3 dah ana nafsy ma3rfsh be3ml aeh w shokran
        String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890qwertyuiopasdfghjklzxcvbnm";
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < 15) {
            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
            salt.append(SALTCHARS.charAt(index));
        }
        String saltStr = salt.toString();
        return saltStr;
    }
}
