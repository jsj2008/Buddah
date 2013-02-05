package services.contracts;

import java.net.HttpURLConnection;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.*;
import javax.xml.bind.JAXBElement;

import com.google.gson.Gson;

import constants.LoggingConstants;
import constants.QueueConstants;

import logging.CorrelationLogData;
import logging.Logger;

import services.requests.*;
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
    static final String HeaderXForwardedFor = "X-Forwarded-For";
    
    //
    // Account Service Endpoints
    //

    @OPTIONS
    @Path( "initiateRegister" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response initiateRegisterPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());

        Logger.logRequest( req, "initiateRegisterPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @PUT
    @Path( "initiateRegister" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response initiateRegister( @Context HttpServletRequest req, InitiateRegisterRequest initiateRegisterRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        
        Logger.logRequest( req, "initiateRegister", initiateRegisterRequest, correlationLogData, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.initiateRegisterProcessor( initiateRegisterRequest, correlationLogData);
    }

    @OPTIONS
    @Path( "confirmRegister" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response confirmRegisterPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "confirmRegisterPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "confirmRegister" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response confirmRegister( @Context HttpServletRequest req, ConfirmRegisterRequest confirmRegisterRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "confirmRegister", confirmRegisterRequest, correlationLogData, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.confirmRegisterProcessor( confirmRegisterRequest, correlationLogData);
    }

    @OPTIONS
    @Path( "login" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response loginPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "loginPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "login" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response login( @Context HttpServletRequest req, LoginRequest loginRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "login", loginRequest, correlationLogData, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.loginProcessor( loginRequest, correlationLogData);
    }

    @OPTIONS
    @Path( "getUserInfo" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getUserInfo( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "getUserInfoPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }
    
    @POST
    @Path( "getUserInfo" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getUserInfo( @Context HttpServletRequest req, GetUserInfoRequest getUserInfoRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "getUserInfo", getUserInfoRequest, correlationLogData, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.getUserInfoProcessor( getUserInfoRequest, correlationLogData);
    }    
    
    @OPTIONS
    @Path( "getUserInfoResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getUserInfoResultPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "getUserInfoResultPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }
    
    @POST
    @Path( "getUserInfoResult" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getUserInfoResult( @Context HttpServletRequest req, GetUserInfoResultRequest getUserInfoResultRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "getUserInfoResult", getUserInfoResultRequest, correlationLogData, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.getUserInfoResultProcessor( getUserInfoResultRequest, correlationLogData);
    } 

    //
    // Posting Service Endpoints
    //

    @OPTIONS
    @Path( "getDeals" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getDealsPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "getDealsPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "getDeals" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getDeals( @Context HttpServletRequest req, GetDealsRequest getDealsRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "getDeals", getDealsRequest, correlationLogData, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.getDealsProcessor( getDealsRequest, correlationLogData);
    }

    @OPTIONS
    @Path( "getDealsResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getDealsResultPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "getDealsResultPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "getDealsResult" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getDealsResult( @Context HttpServletRequest req, GetDealsResultRequest getDealsResultRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "getDealsResult", getDealsResultRequest, correlationLogData, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.getDealsResultProcessor( getDealsResultRequest, correlationLogData);
    }

    @OPTIONS
    @Path( "rating" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response ratingPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "ratingPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "rating" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response rating( @Context HttpServletRequest req, RatingRequest ratingRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "rating", ratingRequest, correlationLogData, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.ratingProcessor( ratingRequest, correlationLogData);
    }

    @OPTIONS
    @Path( "posting" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response postingPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "postingPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @PUT
    @Path( "posting" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response posting( @Context HttpServletRequest req, PostingRequest postingRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "posting", postingRequest, correlationLogData, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.postingProcessor( postingRequest, correlationLogData);
    }

    @OPTIONS
    @Path( "viewUserRating" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response viewUserRatingPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "viewUserRatingPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "viewUserRating" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response viewUserRating( @Context HttpServletRequest req, ViewUserRatingRequest viewUserRatingRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "viewUserRating", viewUserRatingRequest, correlationLogData, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.viewUserRatingProcessor( viewUserRatingRequest, correlationLogData);
    }

    @OPTIONS
    @Path( "viewUserRatingResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response viewUserRatingResultPreflight( @Context HttpServletRequest req )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "viewUserRatingResultPreflight", null, correlationLogData, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "viewUserRatingResult" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response viewUserRatingResult( @Context HttpServletRequest req,
            ViewUserRatingResultRequest viewUserRatingResultRequest )
    {
        CorrelationLogData correlationLogData = new CorrelationLogData(req.getHeader( HeaderXForwardedFor ), UUID.randomUUID().toString());
        Logger.logRequest( req, "viewUserRatingResult", viewUserRatingResultRequest, correlationLogData, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.viewUserRatingResultProcessor( viewUserRatingResultRequest, correlationLogData);
    }

}
