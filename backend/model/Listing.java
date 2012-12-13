package model.services;

import java.sql.Time;

import javax.xml.datatype.Duration;


public class Listing
{
    private String username;
    private String cellphone;
    private Position position;
    private String description;
    private float rating;
    private float price;
    private Time startTime;
    private Duration duration;
    
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

    public float getRating()
    {
        return rating;
    }

    public void setRating( float rating )
    {
        this.rating = rating;
    }

    public Time getStartTime()
    {
        return startTime;
    }

    public void setStartTime( Time startTime )
    {
        this.startTime = startTime;
    }

    public Duration getDuration()
    {
        return duration;
    }

    public void setDuration( Duration duration )
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

    public float getPrice()
    {
        return price;
    }

    public void setPrice( float price )
    {
        this.price = price;
    }

}
