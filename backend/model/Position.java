package model.services;

public class Position
{
    private double longitude;
    private double latitude;

    public Position()
    {
    }

    public double getLongitude()
    {
        return longitude;
    }

    public void setLongitude( double d )
    {
        this.longitude = d;
    }

    public double getLatitude()
    {
        return latitude;
    }

    public void setLatitude( double d )
    {
        this.latitude = d;
    }

}
