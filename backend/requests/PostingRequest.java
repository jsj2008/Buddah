package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Listing;

@XmlRootElement
public class PostingRequest
{
    private String userToken;
    private String username;
    private Listing listing;
    
    public PostingRequest()
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

    public Listing getListing()
    {
        return listing;
    }

    public void setListing( Listing listing )
    {
        this.listing = listing;
    }
    
}
