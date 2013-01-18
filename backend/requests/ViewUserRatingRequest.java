package services.requests;

public class ViewUserRatingRequest
{
    String userToken;
    String usernameDealer;
    
    public ViewUserRatingRequest()
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
    
}
