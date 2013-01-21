package services.contracts;

import java.util.Calendar;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.*;
import javax.xml.bind.JAXBElement;

import com.google.gson.Gson;

import constants.QueueConstants;

import logging.Logger;

import services.queue.*;
import services.requests.*;
import services.responses.*;
import services.worker.AccountWorkProcessor;
import services.worker.PostingWorkProcessor;
import utilities.services.ServiceModifiers;

// Service endpoint will be base url 'http://buddah.herokuapp.com/' followed by the @Path for the service and a specific endpoint,
// ex initiateRegister url = 'http://buddah.herokuapp.com/services/initiateRegister'
// 
// All service endpoints come in pairs to deal with cross site scripting (there's probably a better way, but for now this is it)
//
// @OPTIONS endpoints are for browser pre-flight requests
// @PUT, POST, GET, DELETE corresponding pairs are real requests that are made after pre-flights or directly

@Path( "/services" )
@Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON, MediaType.TEXT_PLAIN } )
public class BuddahService
{
    private final static String ACCOUNT_QUEUE = QueueConstants.ACCOUNT_QUEUE;
    private final static String POSTING_QUEUE = QueueConstants.POSTING_QUEUE;

    private static Gson gson = new Gson();

    @OPTIONS
    @Path( "initiateRegister" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response initiateRegisterPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "initiateRegisterPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @PUT
    @Path( "initiateRegister" )
    @Consumes( { MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_JSON } )
    public Response initiateRegister( @Context HttpServletRequest req, InitiateRegisterRequest initiateRegisterRequest )
    {
        Logger.logRequest( req, "initiateRegister" );

        return ServiceModifiers.wrapHeaders( AccountWorkProcessor.initiateRegisterProcessor( initiateRegisterRequest ),
                MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "confirmRegister" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response confirmRegisterPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "confirmRegisterPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "confirmRegister" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_JSON } )
    public Response confirmRegister( @Context HttpServletRequest req, ConfirmRegisterRequest confirmRegisterRequest )
    {
        Logger.logRequest( req, "confirmRegister" );

        return ServiceModifiers.wrapHeaders( AccountWorkProcessor.confirmRegisterProcessor( confirmRegisterRequest ),
                MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "login" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response loginPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "loginPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "login" )
    @Consumes( { MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_JSON } )
    public Response login( @Context HttpServletRequest req, LoginRequest loginRequest )
    {
        Logger.logRequest( req, "login" );

        return ServiceModifiers.wrapHeaders( AccountWorkProcessor.loginProcessor( loginRequest ),
                MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "getDeals" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getDealsPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "getDealsPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "getDeals" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getDeals( @Context HttpServletRequest req, GetDealsRequest getDealsRequest )
    {
        Logger.logRequest( req, "getDeals" );

        return ServiceModifiers.wrapHeaders( PostingWorkProcessor.getDealsProcessor( getDealsRequest ),
                MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "getDealsResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getDealsResultPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "getDealsResultPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "getDealsResult" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getDealsResult( @Context HttpServletRequest req, GetDealsResultRequest getDealsResultRequest )
    {
        Logger.logRequest( req, "getDealsResult" );

        return ServiceModifiers.wrapHeaders( PostingWorkProcessor.getDealsResultProcessor( getDealsResultRequest ),
                MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "rating" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response ratingPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "ratingPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "rating" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response rating( @Context HttpServletRequest req, RatingRequest ratingRequest )
    {
        Logger.logRequest( req, "rating" );

        return ServiceModifiers.wrapHeaders( PostingWorkProcessor.ratingProcessor( ratingRequest ),
                MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "posting" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response postingPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "postingPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @PUT
    @Path( "posting" )
    public Response posting( @Context HttpServletRequest req, PostingRequest postingRequest )
    {
        Logger.logRequest( req, "posting" );

        return ServiceModifiers.wrapHeaders( PostingWorkProcessor.postingProcessor( postingRequest ),
                MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "viewUserRating" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response viewUserRatingPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "viewUserRatingPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "viewUserRating" )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response viewUserRating( @Context HttpServletRequest req, ViewUserRatingRequest viewUserRatingRequest )
    {
        Logger.logRequest( req, "viewUserRating" );

        // TODO verify token in request

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( POSTING_QUEUE, "viewUserRating".getBytes() );
        WorkerQueue.SendMessage( POSTING_QUEUE, gson.toJson( viewUserRatingRequest ).getBytes() );

        ViewUserRatingResponse response = new ViewUserRatingResponse();

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "viewUserRatingResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response viewUserRatingResultPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "viewUserRatingResultPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "viewUserRatingResult" )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response viewUserRatingResult( @Context HttpServletRequest req,
            ViewUserRatingResultRequest viewUserRatingResultRequest )
    {
        Logger.logRequest( req, "viewUserRatingResult" );

        // TODO verify token in request

        // TODO Redis retrieval

        ViewUserRatingResultResponse response = new ViewUserRatingResultResponse();

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

}
