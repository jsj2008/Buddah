package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.AccountApp;

@XmlRootElement
public class GetUserInfoResultResponse
{    
    
    boolean ready;
    AccountApp accountApp;

    public GetUserInfoResultResponse()
    {
        // TODO Auto-generated constructor stub
    }


    public boolean isReady()
    {
        return ready;
    }

    public void setReady( boolean ready )
    {
        this.ready = ready;
    }
    
    public AccountApp getAccountApp()
    {
        return accountApp;
    }

    public void setAccountApp( AccountApp accountApp )
    {
        this.accountApp = accountApp;
    }


}
