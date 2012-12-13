package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Feedback;

@XmlRootElement
public class RatingRequest
{
    private String userId;
    private String username;
    private Feedback feedback;    
    
    public RatingRequest()
    {
    }

    public String getUsername()
    {
        return username;
    }

    public void setUsername( String username )
    {
        this.username = username;
    }

    public Feedback getFeedback()
    {
        return feedback;
    }

    public void setFeedback( Feedback feedback )
    {
        this.feedback = feedback;
    }

    public String getUserId()
    {
        return userId;
    }

    public void setUserId( String userId )
    {
        this.userId = userId;
    }

}
