package model.services;

public class Position
{
    private double longitude;
    private double latitude;

    public Position()
    {
    }

    public Position( double longitude, double latitude )
    {
        this.longitude = longitude;
        this.latitude = latitude;
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

    public Position findUpperLeftPos( double xOffset, double yOffset )
    {
        return new Position( this.latitude + xOffset, this.longitude - yOffset );
    }

    public Position findUpperRightPos( double xOffset, double yOffset )
    {
        return new Position( this.latitude + xOffset, this.longitude + yOffset );
    }

    public Position findLowerLeftPos( double xOffset, double yOffset )
    {
        return new Position( this.latitude - xOffset, this.longitude - yOffset );
    }

    public Position findLowerRightPos( double xOffset, double yOffset )
    {
        return new Position( this.latitude - xOffset, this.longitude + yOffset );
    }

    
    // TODO transform Position from database.model to service.model
    public boolean isPositionWithin( model.database.Position queryPosition, double xOffset, double yOffset )
    {
        return ( ( queryPosition.getLatitude() < this.latitude + yOffset )
                && ( queryPosition.getLatitude() > this.latitude - yOffset )
                && ( queryPosition.getLongitude() < this.longitude + xOffset ) 
                && ( queryPosition.getLongitude() > this.longitude - xOffset ) );
    }

}