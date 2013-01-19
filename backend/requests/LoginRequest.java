package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class LoginRequest
{
    private String userToken;
    private String username;

    public LoginRequest()
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

    public String toString()
    {
        return "userToken: " + userToken;
    }
}
