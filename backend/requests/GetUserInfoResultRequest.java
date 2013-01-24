package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class GetUserInfoResultRequest
{
    String userToken;
    String username;
    String guid;
    
    public GetUserInfoResultRequest()
    {
        // TODO Auto-generated constructor stub
    }    
    
    public String getUserToken()
    {
        return userToken;
    }
    
    public String getUsername()
    {
        return username;
    }

    public void setUsername( String username )
    {
        this.username = username;
    }

    public void setUserToken( String userToken )
    {
        this.userToken = userToken;
    }
    
    public String getGuid()
    {
        return guid;
    }

    public void setGuid( String guid )
    {
        this.guid = guid;
    }

}
