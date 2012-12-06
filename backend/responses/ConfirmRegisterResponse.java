package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class ConfirmRegisterResponse
{
    private String token;

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

}
