package model.services;

public class Feedback
{
    private double rating;
    private long timeOfRating;
    private String commentary;
    private String title;
    private String usernameDealer;
    
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
        this.setTitle( feedback.getTitle() );
        this.setUsernameDealer( feedback.getUsernameDealer() );
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle( String title )
    {
        this.title = title;
    }

    public String getUsernameDealer()
    {
        return usernameDealer;
    }

    public void setUsernameDealer( String usernameDealer )
    {
        this.usernameDealer = usernameDealer;
    }    
    
    
}

