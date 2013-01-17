package services.responses;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Listing;

@XmlRootElement
public class GetDealsResultResponse
{
    ArrayList<Listing> listings; 

    public GetDealsResultResponse()
    {
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
