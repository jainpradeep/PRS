class PobHub {
  List<Pob> pob;

  PobHub({this.pob});

  PobHub.fromJson(Map<String, dynamic> json) {
    if (json['pob'] != null) {
      pob = new List<Pob>();
      json['pob'].forEach((v) {
        pob.add(new Pob.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pob != null) {
      data['pob'] = this.pob.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pob{  
String id;
String teamid;
String nominatedOfficer;
String nomineeRegion;
String nominatedBy;
String nominatingRegion;
String dtNomination;
String nominatingRemarks;
String prsReportingBaseUnitHq;
int recommEmpno;
String recommEmpname;
String location;
String desgn;
String sapDept;
int month;
int year;
String fy;
    
      Pob({ 
        this.id,
        this.teamid,
        this.nominatedOfficer,
        this.nomineeRegion,
        this.nominatedBy,
        this.nominatingRegion,
        this.dtNomination,
        this.nominatingRemarks,
        this.prsReportingBaseUnitHq,
        this.recommEmpno,
        this.recommEmpname,
        this.location,
        this.desgn,
        this.sapDept,
        this.month,
        this.year,
        this.fy,
      });
      
      
      Pob.fromJson(Map<String,dynamic> json){
   //     print(json);
        this.id= json['ID'];
        this.teamid= json['TEAMID'];
        this.nominatedOfficer= json['NOMINATED_OFFICER'];
        this.nomineeRegion= json['NOMINEE_REGION'];
        this.nominatedBy= json['NOMINATED_BY'];
        this.nominatingRegion= json['NOMINATING_REGION'];
        this.dtNomination= json['DT_NOMINATION'];
        this.nominatingRemarks= json['NOMINATING_REMARKS'];
        this.prsReportingBaseUnitHq= json['PRS_REPORTING_BASE_UNIT_HQ'];
        this.recommEmpno= json['RECOMM_EMPNO'];
        this.recommEmpname= json['RECOMM_EMPNAME'];
        this.location= json['LOCATION'];
        this.desgn= json['DESGN'];
        this.sapDept= json['SAP_DEPT'];
        this.month= json['MONTH'];
        this.year= json['YEAR'];
        this.fy= json['FY'];
      }
      
      Map<String, dynamic> toJson(){ 
        final Map<String, dynamic> data = new Map<String, dynamic>();
          data['id']= this.id;
          data['teamid']= this.teamid;
          data['nominatedOfficer']= this.nominatedOfficer;
          data['nomineeRegion']= this.nomineeRegion;
          data['nominatedBy']= this.nominatedBy;
          data['nominatingRegionid']= this.nominatingRegion;
          data['dtNomination']= this.dtNomination;
          data['nominatingRemarks']= this.nominatingRemarks;
          data['prsReportingBaseUnitHq']= this.prsReportingBaseUnitHq;
          data['recommEmpno']= this.recommEmpno;
          data['recommEmpname']= this.recommEmpname;
          data['location']= this.location;
          data['desgn']= this.desgn;
          data['sapDept']= this.sapDept;
          data['month']= this.month;
          data['year']= this.year;
          data['fy']= this.fy;
          return data;
    }

// class NextEvolution {
//   String num;
//   String name;

//   NextEvolution({this.num, this.name});

//   NextEvolution.fromJson(Map<String, dynamic> json) {
//     num = json['num'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['num'] = this.num;
//     data['name'] = this.name;
//     return data;
//   }
// }
}