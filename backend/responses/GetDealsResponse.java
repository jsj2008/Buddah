package services.responses;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Listing;

@XmlRootElement
public class GetDealsResponse
{
    ArrayList<Listing> listings; 

    public GetDealsResponse()
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
