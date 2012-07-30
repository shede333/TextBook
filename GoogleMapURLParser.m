//
//  GoogleMapURLParser.m
//  mapTest
//
//  Created by Zhihuiguan Zhihuiguan on 12-3-8.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//
//http://code.google.com/intl/zh-CN/apis/maps/documentation/directions/



#import "GoogleMapURLParser.h"




#define  URL_OUT_TIME 8


@implementation GoogleMapURLParser


/***************************************************
 
 Directions API 的请求采用以下形式：
 http://maps.googleapis.com/maps/api/directions/output?parameters
 其中，output 可能是以下任何一个值：
 json（建议）表示以 JavaScript 对象表示法 (JSON) 的形式输出
 xml 表示以 XML 的形式输出
 要通过 HTTPS 访问 Directions API，请使用以下网址：
 https://maps.googleapis.com/maps/api/directions/output?parameters
 如果应用程序包含敏感的用户数据（例如用户所处位置），推荐在请求中使用 HTTPS。
 
 请求参数
 有些参数是必填参数，而有些参数则是可选参数。根据网址的标准，所有参数均使用字符 & (&) 分隔。下面枚举了这些参数及其可能的值。
 Google Directions API 使用以下网址参数定义路线请求：
 origin（必填）- 希望根据其计算路线的地址或文本纬度/经度值。*
 destination（必填）- 希望根据其计算路线的地址或文本纬度/经度值。*
 mode（可选，默认为 driving）- 指定计算路线时使用的出行方式。在出行方式中指定有效的值。
        计算路线时，您可以指定要使用的交通 mode。默认情况下，将路线计算为 driving 路线。目前支持以下出行方式：
        driving（默认）指示使用路网的标准行车路线。
        walking 请求途经步行街和人行道（如果有）的步行路线。
        bicycling 请求途经自行车道和优先街道的骑行路线（目前仅在美国提供）。
        注意：步行路线和骑行路线有时可能不包含畅通无阻的步行街或骑行道，因此，这些路线将会在您必须向用户显示的传回结果中传回 warnings。
 
 waypoints（可选）指定一组路标。路标通过经过指定的位置可以改变路线。可以以纬度/经度坐标或将进行地址解析的地址的形式指定路标。（有关路标的详细信息，请参见下文的在路线中使用路标。）
 alternatives（可选）设置为 true 时，可以指定路线服务可以在响应中提供多条备选路线。请注意，提供备选路线可能增加服务器的响应时间。
 avoid（可选）指示计算的路线应避开指定的地图项。目前，此参数支持以下两个参数：
 tolls 指示计算的路线应避开收费公路/桥梁。
 highways 指示计算的路线应避开高速公路。
 （有关详细信息，请参见下文的路线限制。）
 units（可选）- 指定显示结果时使用的单位制。在下面的单位制中指定有效值。
 region（可选）- 区域代码，指定为 ccTLD（“顶级域”）双字符值。（有关详细信息，请参见下文的区域偏向。）
 language（可选）- 传回结果时所使用的语言。请参见支持的区域语言列表。请注意，我们会经常更新支持的语言，因此该列表可能并不详尽。如果未提供 language，那么，路线服务将会尽可能地尝试使用浏览器的本机语言。有关详细信息，请参见区域偏向。
 sensor（必填）- 指示路线请求是否来自装有位置传感器的设备。该值必须为 true 或 false。
 * 注意：您可以使用多个参数传递地址或纬度/经度坐标。如果将地址作为字符串传递，那么，路线服务将会对该字符串进行地址解析，然后将其转换为纬度-经度坐标，以计算路线。如果您传递的是坐标值，请确保维度值与经度值之间无空格。 
 
 http://maps.googleapis.com/maps/api/directions/json?origin=(31.290196,120.660156)&destination=(31.2548,%20120.6093)&sensor=false
 
 https://maps.googleapis.com/maps/api/directions/json?origin=%E8%8B%8F%E5%B7%9E%E5%B8%82%E5%A8%84%E8%91%91%E9%95%87&destination=%E8%8B%8F%E5%B7%9E%E5%B8%82%E5%94%AF%E4%BA%AD&sensor=false
 
***************************************************/

+ (void)showAlert:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网址参数错误"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确认"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

+ (NSString *)creatURLWithSafe:(BOOL)isSafe 
                     andOrigin:(NSString *)origin 
                andDestination:(NSString *)destination 
                       andMode:(NSString *)mode 
               andAlternatives:(NSString *)alternatives 
                      andUnits:(NSString *)units 
                     andRegion:(NSString *)region 
                   andLanguage:(NSString *)language 
                     andSensor:(NSString *)sensor
{
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:10];
    if (origin !=nil) {
        [mArr addObject:[NSString stringWithFormat:@"origin=%@",origin]];
    }else{
        [self showAlert:@"origin不能为空"];
        [mArr release];
        return nil;
    }
    
    if (destination !=nil) {
        [mArr addObject:[NSString stringWithFormat:@"destination=%@",destination]];
    }else{
        [self showAlert:@"destination不能为空"];
        [mArr release];
        return nil;
    }
    
    //默认为 driving
    if (mode !=nil) {
        [mArr addObject:[NSString stringWithFormat:@"mode=%@",mode]];
    }
    
    if (alternatives !=nil) {
        [mArr addObject:[NSString stringWithFormat:@"alternatives=%@",alternatives]];
    }
    
    if (units !=nil) {
        [mArr addObject:[NSString stringWithFormat:@"units=%@",units]];
    }
    
    if (region !=nil) {
        [mArr addObject:[NSString stringWithFormat:@"region=%@",region]];
    }
    
    if (language !=nil) {
        [mArr addObject:[NSString stringWithFormat:@"language=%@",language]];
    }
    
    if (sensor !=nil) {
        [mArr addObject:[NSString stringWithFormat:@"sensor=%@",sensor]];
    }else{
        [self showAlert:@"sensor不能为空"];
        [mArr release];
        return nil;
    }
    
    NSString *http;
    if (isSafe) {
        http = GM_BASE_URL_SAFE;
    }else{
        http = GM_BASE_URL;
    }
    
    NSString *parameters = [mArr componentsJoinedByString:@"&"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",http,parameters];
    
    [mArr release];
    
    return url;
}





+ (id) getDataInJsonWithURL:(NSString *)URL {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    NSLog(@"sw-2-URL: %@\n",URL);
	NSURL *myURL = [NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:URL_OUT_TIME];
    
    
	NSHTTPURLResponse * response = nil;
	NSError * error = nil;
	NSData * data = [[NSData alloc] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error]];
    
//    NSLog(@"sw-2-data %@\n",data);
    
    if (error != nil) {
        [data release];
        [pool release];
        return nil;
    }
    
	int statusCode = [response statusCode];

	
	if (statusCode>=200 && statusCode<300) {
        id receiveData = [[NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error] retain];
        [pool release];
        [data release];
        
		return [receiveData autorelease];
	}else {
        [data release];
        [pool release];
		return nil;
	}
}

/***************************************************
 
 OK 表示响应包含一个有效的 result。
 NOT_FOUND 表示至少有一个在请求的起点、目的地或路标中指定的位置无法进行地址解析。
 ZERO_RESULTS 表示无法在起点和终点之间找到路线。
 MAX_WAYPOINTS_EXCEEDED 表示请求中包含过多的 waypoints。允许的最大 waypoints 数为 8，再加上起点和目的地。（Google Maps Premier 客户可以在请求中提及多达 23 个路标。）
 INVALID_REQUEST 表示提供的请求无效。
 OVER_QUERY_LIMIT 表示该服务在允许的时间段内从您的应用程序收到了过多的请求。
 REQUEST_DENIED 表示该服务已拒绝您的应用程序使用路线服务。
 UNKNOWN_ERROR 表示路线请求因服务器出错而无法得到处理。如果您再试一次，该请求可能会成功。

***************************************************/


+ (NSString *)getStatus:(NSDictionary *)dic{
    NSString *status = [dic objectForKey:@"status"];
    
    return status;
    
}


#pragma mark - routes-各个状态

/***************************************************
 
 routes 数组的每个元素都包含一个来自指定起点和目的地的结果。此路线可能包含一个或多个 legs，具体取决于是否指定了任何路标。此外，除路线信息外，该路线还包含必须向用户显示的版权和警告信息。
 routes 字段中的每个路线都可能包含以下字段：
 
    summary 包含路线的简短文本描述，适于命名路线以及消除路线与备选路线之间的歧义。
    legs[] 包含一个数组，该数组包含关于路线的一段路程（介于指定路线中两个位置之间）的信息。系统将会为指定的每个路标或目标显示一个单独的路程。（一个没有路标的路线在 legs 数组中仅包含一段路程。）每个路程均由一系列 steps 组成。（请参见下文的路线路程。）
    waypoint_order 包含一个指示计算路线中所有路标顺序的数组。如果通过某请求的 waypoints 参数向该请求传递了 optimize:true，则这些路标可能会重新排序。
    overview_polyline 包含一个对象，该对象包含一组表示生成路线的近似（平滑）路径的已编码 points 和 levels。
    bounds 包含该路线的视口边框。
    copyrights 包含将要为此路线显示的版权文本。您必须自行处理和显示此信息。
    warnings[] 包含将在显示这些路线时显示的一系列警告。您必须自行处理和显示这些警告。
 
***************************************************/

+ (NSString *)getRoutesValue:(NSDictionary *)dic andKey:(NSString *)key andIndex:(int)index{
    
    //summary,copyrights
    if ([key isEqualToString:@"legs"] || [key isEqualToString:@"overview_polyline"] || [key isEqualToString:@"bounds"] || [key isEqualToString:@"warnings"]) {
        NSAssert(0, @"此属性不是String，请看下面的方法" );
    }
    
    NSDictionary *dicOfRoutes = [[dic objectForKey:@"routes"] objectAtIndex:index];
    
    if ([[dicOfRoutes objectForKey:key] isKindOfClass:[NSString class]]) {
        NSString *value = [dicOfRoutes objectForKey:key];
        return value;
    }else{
        NSAssert(0, @"不是string类");
        return nil;
    }
    
    
}

+ (NSDictionary *)getRoutesBounds:(NSDictionary *)dic andIndex:(int)index{
    NSDictionary *dicOfRoutes = [[dic objectForKey:@"routes"] objectAtIndex:index];
    
    if ([[dicOfRoutes objectForKey:@"bounds"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *value = [dicOfRoutes objectForKey:@"bounds"];
        return value;
    }else{
        NSAssert(0, @"不是NSDictionary类");
        return nil;
    }
    
}

//legs,waypoint_order,warnings
+ (NSArray *)getRoutesArr:(NSDictionary *)dic andKey:(NSString *)key andIndex:(int)index{
    
    NSDictionary *dicOfRoutes = [[dic objectForKey:@"routes"] objectAtIndex:index];
    
    if ([[dicOfRoutes objectForKey:key] isKindOfClass:[NSArray class]]) {
        NSArray *value = [dicOfRoutes objectForKey:key];
        return value;
    }else{
        NSAssert(0, @"不是NSArray类");
        return nil;
    }
    
}

#pragma mark - legs各个字段信息

/***************************************************
 
legs 字段中的每个路程都可能包含以下字段：
 
 steps[] 包含一组路段，这些路段用于指示有关行程路程的每个单独路段的信息。（请参见下文的路线路段。）
 
 distance 通过一个带有以下元素的字段指示这段路程包含的总距离：
 value 表示距离（以米为单位）
 text 中包含可人工读取的距离表示方式，显示的单位为起点所采用的单位（或请求的 units 参数中所指定的单位），语言为请求中所指定的语言。（例如，对于美国内的任何起点都将使用英里和英尺。）请注意，无论何种单位制显示为文本，distance.value 字段始终包含一个以米为单位表示的值。
  如果距离未知，则这些字段可能不存在。
 
 duration 通过一个带有以下元素的字段指示这段路程的总持续时间：
 value 表示持续时间（以秒为单位）。
 text 包含持续时间的可人工读取的表示形式。
  如果持续时间未知，则这些字段可能不存在。
 
 start_location 包含这段路程起点的纬度/经度坐标。由于路线 Google Directions API 通过使用起点和终点处最近的交通选项（通常为道路）计算不同位置间的路线，因此，start_location 可能与此路程提供的起点不同，例如因为道路不靠近该起点。
 
 end_location 包含这段路程的指定目的地的纬度/经度坐标。由于路线 API 通过使用起点和终点处最近的交通选项（通常为道路）计算不同位置间的路线，因此，end_location 可能与此路程提供的目的地不同，例如因为道路不靠近该目的地。
 
 start_address 包含反映此路程的 start_location 的可人工读取的地址（通常为街道地址）。
 
 end_addresss 包含反映此路程的 end_location 的可人工读取的地址（通常为街道地址）。
 
 via_waypoint 暂时不用
 
 ***************************************************/

//key:distance,duration,end_location,start_location
+ (NSDictionary *)getLegsDic:(NSDictionary *)dic andKey:(NSString *)key andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes{
    
    //distance,duration,end_location,start_location
    NSArray *arr = [self getRoutesArr:dic andKey:@"legs" andIndex:indexOfRoutes];
    id tmp = [[arr objectAtIndex:indexOfLegs] objectForKey:key];
    if ([tmp isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)tmp;
    }else{
        NSAssert(0, @"不是NSDictionary类");
        return nil;
    }
    
}

//key:end_address,start_address
+ (NSString *)getLegsString:(NSDictionary *)dic andKey:(NSString *)key andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes{
    
    //distance,duration,end_location,start_location
    NSArray *arr = [self getRoutesArr:dic andKey:@"legs" andIndex:indexOfRoutes];
    id tmp = [[arr objectAtIndex:indexOfLegs] objectForKey:key];
    if ([tmp isKindOfClass:[NSString class]]) {
        return (NSString *)tmp;
    }else{
        NSAssert(0, @"不是NSString类");
        return nil;
    }
    
}

//各个路段，默认
+ (NSArray *)getLegsStep:(NSDictionary *)dic andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes{
    
    NSArray *arr = [self getRoutesArr:dic andKey:@"legs" andIndex:indexOfRoutes];
    id tmp = [[arr objectAtIndex:indexOfLegs] objectForKey:@"steps"];
    if ([tmp isKindOfClass:[NSArray class]]) {
        return (NSArray *)tmp;
    }else{
        NSAssert(0, @"不是NSArray类");
        return nil;
    }
}

/***************************************************
 
steps 数组中的每个元素定义计算的路线中的一个路段。路段是路线线路的最小单位，包含一个路段介绍有关该行程的一个具体说明。例如，“在西四街左转”。这个路段不仅介绍了说明，同时也包含有关此路段到下个路段的距离和持续时间信息。例如，一个指示“并入 I-80 West”的路段可能包含距离“37 英里”和持续时间“40 分钟”的信息，指示下一个路段距离此路段有 37 英里/40 分钟。
steps 字段中的每个路段都可能包含以下字段：
 html_instructions 包含此路段的已确定格式的说明（以 HTML 文本字符串表示）。
 distance 包含此路段距离下一个路段的距离。（请参见上文的路线路程中对此字段的介绍。）如果距离未知，那么此字段可能未被定义。
 duration 包含走完此路段到下一个路段通常所需的时间（请参见上文的路线路程。）如果持续时间未知，那么，此字段可能未被定义。
 start_location 包含此路段起点的位置，以一组 lat 和 lng 字段表示。
 end_location 包含此路段起点的位置，以一组 lat 和 lng 字段表示。

***************************************************/








#pragma mark - 用于绘制地图路线的数据

+ (MKPolyline *)getPolyline:(NSDictionary *)dic andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes{
    
//    CLLocationCoordinate2D *malloc(sizeof(CLLocationCoordinate2D) * pointStrings.count);
    NSArray *arrOfStep = [self getLegsStep:dic andIndexOfLegs:indexOfLegs andIndexOfRoutes:indexOfRoutes];
    int count = [arrOfStep count];
    CLLocationCoordinate2D points[count + 1];
    
    
    for (int i = 0; i < count; i++) {
        points[i].latitude = [[[[arrOfStep objectAtIndex:i] objectForKey:@"start_location"] objectForKey:@"lat"] doubleValue];
        points[i].longitude = [[[[arrOfStep objectAtIndex:i] objectForKey:@"start_location"] objectForKey:@"lng"] doubleValue];
    }
    
    points[count].latitude = [[[[arrOfStep lastObject] objectForKey:@"end_location"] objectForKey:@"lat"] doubleValue];
    points[count].longitude = [[[[arrOfStep lastObject] objectForKey:@"end_location"] objectForKey:@"lng"] doubleValue];
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:points count:(count + 1)];
    
//    free(points);
    
    return polyline;
}


+ (NSArray *)getAnnotation:(NSDictionary *)dic andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes{
    NSArray *arrOfStep = [self getLegsStep:dic andIndexOfLegs:indexOfLegs andIndexOfRoutes:indexOfRoutes];
    int count = [arrOfStep count];
    
    NSMutableArray *arrOfAnnotation = [[[NSMutableArray alloc] initWithCapacity:(count + 1)] autorelease];
    for (NSDictionary *subDic in arrOfStep) {
        [arrOfAnnotation addObject:[self getSubAnnotation:subDic andKey:@"start_location"]];
    }
    
    [arrOfAnnotation addObject:[self getSubAnnotation:[arrOfStep lastObject] andKey:@"end_location"]];
    
    SubAnnotation *annotationOfOrigin = [arrOfAnnotation objectAtIndex:0];
    [annotationOfOrigin setAnnotationType:1];
    SubAnnotation *annotationOfDestination = [arrOfAnnotation lastObject];
    [annotationOfDestination setAnnotationType:2];
    
    return arrOfAnnotation;
    
    
}

+ (SubAnnotation *)getSubAnnotation:(NSDictionary *)subDic andKey:(NSString *)key{
    SubAnnotation *annotation = [[SubAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[[subDic objectForKey:key] objectForKey:@"lat"] doubleValue];
    coordinate.longitude = [[[subDic objectForKey:key] objectForKey:@"lng"] doubleValue];
    annotation.coordinateSub = coordinate;
    annotation.upTitle = [[subDic objectForKey:@"distance"] objectForKey:@"text"];
    annotation.downTitle = [[subDic objectForKey:@"duration"] objectForKey:@"text"];
    
    return [annotation autorelease];
}

+ (MKMapRect)getVisibleMapRect:(NSDictionary *)dic andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes{
    NSArray *arrOfStep = [self getLegsStep:dic andIndexOfLegs:indexOfLegs andIndexOfRoutes:indexOfRoutes];
    
    CLLocationDegrees latitudeOfMax = -90;
    CLLocationDegrees latitudeOfMin = 90;
    CLLocationDegrees longitudeOfMax = -180;
    CLLocationDegrees longitudeOfMin = 180;

    for (NSDictionary *subDic in arrOfStep) {

        CLLocationDegrees latitudeTmp = [[[subDic objectForKey:@"start_location"] objectForKey:@"lat"] doubleValue];
        CLLocationDegrees longitudeTmp = [[[subDic objectForKey:@"start_location"] objectForKey:@"lng"] doubleValue];
        latitudeOfMax = (latitudeTmp > latitudeOfMax)?latitudeTmp:latitudeOfMax;
        latitudeOfMin = (latitudeTmp < latitudeOfMin)?latitudeTmp:latitudeOfMin;
        longitudeOfMax = (longitudeTmp > longitudeOfMax)?longitudeTmp:longitudeOfMax;
        longitudeOfMin = (longitudeTmp < longitudeOfMin)?longitudeTmp:longitudeOfMin;

    }
    
    CLLocationDegrees latitudeTmp = [[[[arrOfStep lastObject] objectForKey:@"end_location"] objectForKey:@"lat"] doubleValue];
    CLLocationDegrees longitudeTmp = [[[[arrOfStep lastObject] objectForKey:@"end_location"] objectForKey:@"lng"] doubleValue];
    latitudeOfMax = (latitudeTmp > latitudeOfMax)?latitudeTmp:latitudeOfMax;
    latitudeOfMin = (latitudeTmp < latitudeOfMin)?latitudeTmp:latitudeOfMin;
    longitudeOfMax = (longitudeTmp > longitudeOfMax)?longitudeTmp:longitudeOfMax;
    longitudeOfMin = (longitudeTmp < longitudeOfMin)?longitudeTmp:longitudeOfMin;
    
    MKMapPoint letfDownMapPoint = MKMapPointForCoordinate(CLLocationCoordinate2DMake(latitudeOfMin, longitudeOfMin));
    MKMapPoint rightUpMapPoint = MKMapPointForCoordinate(CLLocationCoordinate2DMake(latitudeOfMax, longitudeOfMax));
//    NSLog(@"sw-2-letfDownMapPoint:x:%f,y:%f,rightUpMapPoint:x:%f,y:%f \n",letfDownMapPoint.x,letfDownMapPoint.y,rightUpMapPoint.x,rightUpMapPoint.y);
    MKMapRect mapRect = MKMapRectMake((rightUpMapPoint.x + letfDownMapPoint.x)*0.5,
                                      (rightUpMapPoint.y + letfDownMapPoint.y)*0.5,
                                      fabs(rightUpMapPoint.x - letfDownMapPoint.x),
                                      fabs(rightUpMapPoint.y - letfDownMapPoint.y));
    return mapRect;
    
}




#pragma mark - 用于OurCity的接口

+ (id)OCGetPathFrom:(NSString *)coordianteOfFrom andTO:(NSString *)coordianteOfTo{
    NSString *url = [GoogleMapURLParser creatURLWithSafe:NO
                                               andOrigin:coordianteOfFrom
                                          andDestination:coordianteOfTo
                                                 andMode:nil
                                         andAlternatives:@"true"
                                                andUnits:@"metric"
                                               andRegion:@"cn"
                                             andLanguage:@"zh-CN"
                                               andSensor:@"true"];
    id result = [GoogleMapURLParser getDataInJsonWithURL:url];
    return result;
}

+ (MKMapRect)OCGetVisibleMapRect:(NSDictionary *)dic{
    MKMapRect rect = [self getVisibleMapRect:dic andIndexOfLegs:0 andIndexOfRoutes:0];
    return rect;
}

+ (NSArray *)OCTEst:(NSDictionary *)dic{
    NSArray *arrOfStep = [self getLegsStep:dic andIndexOfLegs:0 andIndexOfRoutes:0];
    
    CLLocationDegrees latitudeOfMax = -90;
    CLLocationDegrees latitudeOfMin = 90;
    CLLocationDegrees longitudeOfMax = -180;
    CLLocationDegrees longitudeOfMin = 180;
    
    for (NSDictionary *subDic in arrOfStep) {
        
        CLLocationDegrees latitudeTmp = [[[subDic objectForKey:@"start_location"] objectForKey:@"lat"] doubleValue];
        CLLocationDegrees longitudeTmp = [[[subDic objectForKey:@"start_location"] objectForKey:@"lng"] doubleValue];
        latitudeOfMax = (latitudeTmp > latitudeOfMax)?latitudeTmp:latitudeOfMax;
        latitudeOfMin = (latitudeTmp < latitudeOfMin)?latitudeTmp:latitudeOfMin;
        longitudeOfMax = (longitudeTmp > longitudeOfMax)?longitudeTmp:longitudeOfMax;
        longitudeOfMin = (longitudeTmp < longitudeOfMin)?longitudeTmp:longitudeOfMin;
        
    }
    
    CLLocationDegrees latitudeTmp = [[[[arrOfStep lastObject] objectForKey:@"end_location"] objectForKey:@"lat"] doubleValue];
    CLLocationDegrees longitudeTmp = [[[[arrOfStep lastObject] objectForKey:@"end_location"] objectForKey:@"lng"] doubleValue];
    latitudeOfMax = (latitudeTmp > latitudeOfMax)?latitudeTmp:latitudeOfMax;
    latitudeOfMin = (latitudeTmp < latitudeOfMin)?latitudeTmp:latitudeOfMin;
    longitudeOfMax = (longitudeTmp > longitudeOfMax)?longitudeTmp:longitudeOfMax;
    longitudeOfMin = (longitudeTmp < longitudeOfMin)?longitudeTmp:longitudeOfMin;
    
    NSLog(@"sw-2- latitudeOfMax%lf,longitudeOfMax%lf,latitudeOfMin%lf,longitudeOfMin%lf\n",latitudeOfMax,longitudeOfMax,latitudeOfMin,longitudeOfMin);
    
    NSMutableArray *arrOfAnnotation = [[[NSMutableArray alloc] initWithCapacity:3] autorelease];
 
    
    SubAnnotation *annotation0 = [[SubAnnotation alloc] init];
    CLLocationCoordinate2D coordinate0 = CLLocationCoordinate2DMake(latitudeOfMin, longitudeOfMin);
    annotation0.coordinateSub = coordinate0;
    annotation0.upTitle = [NSString stringWithFormat:@"%lf",latitudeOfMax];
    annotation0.downTitle = [NSString stringWithFormat:@"max%lf",longitudeOfMax];    
    [annotation0 setAnnotationType:3];
    [arrOfAnnotation addObject:annotation0];
    [annotation0 release];
    
    SubAnnotation *annotation1 = [[SubAnnotation alloc] init];
    CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake(latitudeOfMax, longitudeOfMax);
    annotation1.coordinateSub = coordinate1;
    annotation1.upTitle = [NSString stringWithFormat:@"%lf",latitudeOfMin];
    annotation1.downTitle = [NSString stringWithFormat:@"min%lf",longitudeOfMin];    
    [annotation1 setAnnotationType:3];
    [arrOfAnnotation addObject:annotation1];
    [annotation1 release];
    
    
    MKMapPoint letfDownMapPoint = MKMapPointForCoordinate(CLLocationCoordinate2DMake(latitudeOfMin, longitudeOfMin));
    MKMapPoint rightUpMapPoint = MKMapPointForCoordinate(CLLocationCoordinate2DMake(latitudeOfMax, longitudeOfMax));
    //    NSLog(@"sw-2-letfDownMapPoint:x:%f,y:%f,rightUpMapPoint:x:%f,y:%f \n",letfDownMapPoint.x,letfDownMapPoint.y,rightUpMapPoint.x,rightUpMapPoint.y);
    MKMapRect mapRect = MKMapRectMake((rightUpMapPoint.x + letfDownMapPoint.x)*0.5,
                                      (rightUpMapPoint.y + letfDownMapPoint.y)*0.5,
                                      fabs(rightUpMapPoint.x - letfDownMapPoint.x),
                                      fabs(rightUpMapPoint.y - letfDownMapPoint.y));
    

    
    
    SubAnnotation *annotation3 = [[SubAnnotation alloc] init];

    annotation3.coordinateSub = MKCoordinateForMapPoint(MKMapPointMake((rightUpMapPoint.x + letfDownMapPoint.x)*0.5, (rightUpMapPoint.y + letfDownMapPoint.y)*0.5));
    annotation3.upTitle = [NSString stringWithFormat:@"%lf",latitudeOfMin];
    annotation3.downTitle = [NSString stringWithFormat:@"midd%lf",longitudeOfMin];    
    [annotation3 setAnnotationType:3];
    [arrOfAnnotation addObject:annotation3];
    [annotation3 release];
    

    
    return arrOfAnnotation;
    
}








//static GoogleMapURLParser *parser;
//+(GoogleMapURLParser *)shareParser{
//	@synchronized(self){
//		if ( parser == NULL) {
//			parser = [[GoogleMapURLParser alloc]init];
//		}
//	}
//	return parser;
//}

@end
