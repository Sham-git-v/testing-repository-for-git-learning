public class CitySharing {

    public static void shareRecOfCity(id recordId, id userId){
        City__Share ccShare=new City__Share();
        ccShare.ParentId=recordId;
        ccShare.RowCause=Schema.City__Share.RowCause.Manual;
        ccShare.UserOrGroupId=userId;
        ccShare.AccessLevel='Read';
        
        insert ccShare;
    }
}