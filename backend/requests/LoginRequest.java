package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class LoginRequest
{
    private String userId;

    public LoginRequest()
    {
    }

    public String getUserId()
    {
        return userId;
    }

    public void setUserId( String userId )
    {
        this.userId = userId;
    }

    public String toString()
    {
        return "userId: " + userId;
    }
}
