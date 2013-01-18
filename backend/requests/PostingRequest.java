package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Listing;

@XmlRootElement
public class PostingRequest
{
    private String userToken;
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

    public Listing getListing()
    {
        return listing;
    }

    public void setListing( Listing listing )
    {
        this.listing = listing;
    }
    
}
