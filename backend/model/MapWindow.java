package model;

public class MapWindow
{
    private Position upperLeftPosition;
    private Position upperRightPosition;
    private Position lowerLeftPosition;
    private Position lowerRightPosition;
    
    public MapWindow()
    {
    }

    public Position getUpperLeftPosition()
    {
        return upperLeftPosition;
    }

    public void setUpperLeftPosition( Position upperLeftPosition )
    {
        this.upperLeftPosition = upperLeftPosition;
    }

    public Position getUpperRightPosition()
    {
        return upperRightPosition;
    }

    public void setUpperRightPosition( Position upperRightPosition )
    {
        this.upperRightPosition = upperRightPosition;
    }

    public Position getLowerLeftPosition()
    {
        return lowerLeftPosition;
    }

    public void setLowerLeftPosition( Position lowerLeftPosition )
    {
        this.lowerLeftPosition = lowerLeftPosition;
    }

    public Position getLowerRightPosition()
    {
        return lowerRightPosition;
    }

    public void setLowerRightPosition( Position lowerRightPosition )
    {
        this.lowerRightPosition = lowerRightPosition;
    }
    
}
