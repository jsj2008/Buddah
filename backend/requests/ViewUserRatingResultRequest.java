package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class ViewUserRatingResultRequest
{
    String userToken;
    String guid;
    
    public ViewUserRatingResultRequest()
    {
        // TODO Auto-generated constructor stub
    }    
    
    public String getUserToken()
    {
        return userToken;
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
