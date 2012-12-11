package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class InitiateRegisterResponse
{
    private String instructionMessage;
    
    public InitiateRegisterResponse()
    {
    }

    public String getInstructionMessage()
    {
        return instructionMessage;
    }

    public void setInstructionMessage( String instructionMessage )
    {
        this.instructionMessage = instructionMessage;
    }
    
}
