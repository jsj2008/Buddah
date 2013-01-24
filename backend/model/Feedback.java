package model.services;

public class Feedback
{
    private double rating;
    private long timeOfRating;
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

    public long getTimeOfRating()
    {
        return timeOfRating;
    }

    public void setTimeOfRating( long timeOfRating )
    {
        this.timeOfRating = timeOfRating;
    }

    public String getCommentary()
    {
        return commentary;
    }

    public void setCommentary( String commentary )
    {
        this.commentary = commentary;
    }

    public void fromDatabaseFeedback(model.database.Feedback feedback)
    {
        this.setCommentary( feedback.getCommentary() );
        this.setRating( feedback.getRating() );
        this.setTimeOfRating( feedback.getTimeOfRating() );
    }    
}
