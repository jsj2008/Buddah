package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class LoginResponse
{
    private boolean result;

    public LoginResponse()
    {
    }

    public boolean isResult()
    {
        return result;
    }

    public void setResult( boolean result )
    {
        this.result = result;
    }

}
