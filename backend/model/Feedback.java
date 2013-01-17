package model.services;

public class Feedback
{
    private double rating;
    private String commentary;
    
    public Feedback()
    {
    }

    public double getRating()
    {
        return rating;
    }

    public void setRating( double rating )
    {
        this.rating = rating;
    }

    public String getCommentary()
    {
        return commentary;
    }

    public void setCommentary( String commentary )
    {
        this.commentary = commentary;
    }

}
