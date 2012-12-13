package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class ConfirmRegisterRequest
{
    private String activationCode;
    private String username;

    public ConfirmRegisterRequest()
    {
    }

    public String getActivationCode()
    {
        return activationCode;
    }

    public void setActivationCode( String activationCode )
    {
        this.activationCode = activationCode;
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
        return "activationCode: " + activationCode + "\n" + 
               "username: " + username;
    }

}
