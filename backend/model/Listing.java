package model.services;

public class Listing
{
    private String username;
    private String cellphone;
    private Position position;
    private String description;
    
    // TODO get rid of rating per listing?
    private double rating;
    private double price;
    private long startTime;
    private long duration;
    
    public Listing()
    {
    }

    public String getUsername()
    {
        return username;
    }

    public void setUsername( String username )
    {
        this.username = username;
    }

    public String getCellphone()
    {
        return cellphone;
    }

    public void setCellphone( String cellphone )
    {
        this.cellphone = cellphone;
    }

    public Position getPosition()
    {
        return position;
    }

    public void setPosition( Position position )
    {
        this.position = position;
    }

    public double getRating()
    {
        return rating;
    }

    public void setRating( double rating )
    {
        this.rating = rating;
    }

    public long getStartTime()
    {
        return startTime;
    }

    public void setStartTime( long startTime )
    {
        this.startTime = startTime;
    }

    public long getDuration()
    {
        return duration;
    }

    public void setDuration( long duration )
    {
        this.duration = duration;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription( String description )
    {
        this.description = description;
    }

    public double getPrice()
    {
        return price;
    }

    public void setPrice( double price )
    {
        this.price = price;
    }

    public void fromDatabaseListing(model.database.Listing listing)
    {
        this.cellphone = listing.getCellphone();
        this.description = listing.getDescription();
        this.duration = listing.getDuration();
        this.position = listing.getPosition().toServicesPosition();
        this.price = listing.getPrice();
        this.rating = listing.getRating();
        this.startTime = listing.getStartTime();
        this.username = listing.getUsername();
    }
    
}
