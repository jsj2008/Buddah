package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Feedback;

@XmlRootElement
public class RatingRequest
{
    private String userToken;
    private String usernameDealer;
    private Feedback feedback;

    public RatingRequest()
    {
    }

    public String getUserToken()
    {
        return userToken;
    }

    public void setUserToken( String userToken )
    {
        this.userToken = userToken;
    }

    public String getUsernameDealer()
    {
        return usernameDealer;
    }

    public void setUsernameDealer( String usernameDealer )
    {
        this.usernameDealer = usernameDealer;
    }

    public Feedback getFeedback()
    {
        return feedback;
    }

    public void setFeedback( Feedback feedback )
    {
        this.feedback = feedback;
    }

}
