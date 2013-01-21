package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Listing;

@XmlRootElement
public class GetDealsResultResponse
{
    boolean ready;
    Listing[] listings; 

    public GetDealsResultResponse()
    {
    }

    public boolean isReady()
    {
        return ready;
    }

    public void setReady( boolean ready )
    {
        this.ready = ready;
    }

    public Listing[] getListings()
    {
        return listings;
    }

    public void setListings( Listing[] listings )
    {
        this.listings = listings;
    }

}
