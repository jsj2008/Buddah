package services.responses;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Listing;

@XmlRootElement
public class GetDealsResultResponse
{
    boolean ready;
    ArrayList<Listing> listings; 

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

    public ArrayList<Listing> getListings()
    {
        return listings;
    }

    public void setListings( ArrayList<Listing> listings )
    {
        this.listings = listings;
    }

}
