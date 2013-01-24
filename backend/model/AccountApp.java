package model.services;

public class AccountApp
{

    private String usernameDealer;
    private double avgRatings;
    private String cellphone;
    private int numPosts;
    private int numRatings;
    
    public AccountApp()
    {
        // TODO Auto-generated constructor stub
    }

    public String getUsernameDealer()
    {
        return usernameDealer;
    }

    public void setUsernameDealer( String usernameDealer )
    {
        this.usernameDealer = usernameDealer;
    }

    public double getAvgRatings()
    {
        return avgRatings;
    }

    public void setAvgRatings( double avgRatings )
    {
        this.avgRatings = avgRatings;
    }

    public String getCellphone()
    {
        return cellphone;
    }

    public void setCellphone( String cellphone )
    {
        this.cellphone = cellphone;
    }

    public int getNumPosts()
    {
        return numPosts;
    }

    public void setNumPosts( int numPosts )
    {
        this.numPosts = numPosts;
    }

    public int getNumRatings()
    {
        return numRatings;
    }

    public void setNumRatings( int numRatings )
    {
        this.numRatings = numRatings;
    }

    public void fromDatabaseAccountApp(model.database.AccountApp accountApp)
    {
        this.avgRatings = accountApp.getAvgRatings();
        this.cellphone = accountApp.getCellphone();
        this.numPosts = accountApp.getNumPosts();
        this.numRatings = accountApp.getNumRatings();
        this.usernameDealer = accountApp.getUsername();
    }
}
