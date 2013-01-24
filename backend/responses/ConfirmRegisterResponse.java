package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class ConfirmRegisterResponse
{
    private String token;
    private boolean usernameTaken;

    public ConfirmRegisterResponse()
    {
    }

    public String getToken()
    {
        return token;
    }

    public void setToken( String token )
    {
        this.token = token;
    }

    public boolean isUsernameTaken()
    {
        return usernameTaken;
    }

    public void setUsernameTaken( boolean usernameTaken )
    {
        this.usernameTaken = usernameTaken;
    }
}
