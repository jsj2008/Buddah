package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class LoginRequest
{
    private String userToken;

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

    public String toString()
    {
        return "userToken: " + userToken;
    }
}
