package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class GetUserInfoRequest
{
    private String userToken;
    private String username;
    private String usernameDealer;
    
    public GetUserInfoRequest()
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
    
    public String getUsername()
    {
        return username;
    }

    public void setUsername( String username )
    {
        this.username = username;
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
