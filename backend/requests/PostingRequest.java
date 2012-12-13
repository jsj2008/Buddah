package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Listing;

@XmlRootElement
public class PostingRequest
{
    private String userId;
    private Listing listing;
    
    public PostingRequest()
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

    public Listing getListing()
    {
        return listing;
    }

    public void setListing( Listing listing )
    {
        this.listing = listing;
    }
    
}
