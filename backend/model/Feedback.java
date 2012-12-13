package model.services;

public class Feedback
{
    private float rating;
    private String commentary;
    
    public Feedback()
    {
    }

    public float getRating()
    {
        return rating;
    }

    public void setRating( float rating )
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
