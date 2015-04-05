set timing on
set echo on
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
WHENEVER OSERROR EXIT 2 ROLLBACK

-- Run the below pl/sql block in user dtxml..
begin
 dbms_xmlschema.registerSchema(
 SCHEMAURL=>'http://www.dealertrack.com/desklink/Programs_Inc.xsd',
 SCHEMADOC=>'<?xml version="1.0" encoding="ISO-8859-15"?>
<xs:schema elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:oraxdb="http://xmlns.oracle.com/xdb" >
  <xs:element name="ArrayOfProgram" nillable="true" type="ArrayOfProgram" />
  <xs:complexType name="ArrayOfProgram" >
    <xs:sequence>
      <xs:element minOccurs="0" maxOccurs="unbounded" name="Program" nillable="true" type="Program" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="Program" >
    <xs:sequence>
      <xs:element minOccurs="1" maxOccurs="1" name="ProgramId" type="xs:int" />
      <xs:element minOccurs="1" maxOccurs="1" name="LenderId" type="xs:int" />
      <xs:element minOccurs="1" maxOccurs="1" name="Preferred" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="UserRetailProgramId" type="xs:int" />
      <xs:element minOccurs="0" maxOccurs="1" name="LenderCode" type="xs:string" />
      <xs:element minOccurs="0" maxOccurs="1" name="LenderLegalName" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="Captive" type="xs:boolean" />
      <xs:element minOccurs="1" maxOccurs="1" name="BranchId" type="xs:int" />
      <xs:element minOccurs="0" maxOccurs="1" name="Branch" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="CreditTierParameterId" type="xs:int" />
      <xs:element minOccurs="0" maxOccurs="1" name="ProgramName" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="ProgramType" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="ProductType" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="RegionalId" type="xs:int" />
      <xs:element minOccurs="0" maxOccurs="1" name="Title" type="xs:string" />
      <xs:element minOccurs="0" maxOccurs="1" name="Description" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="Use" type="xs:boolean" />
      <xs:element minOccurs="1" maxOccurs="1" name="Quote" type="xs:boolean" />
      <xs:element minOccurs="1" maxOccurs="1" name="FindCreditTier" type="xs:boolean" />
      <xs:element minOccurs="0" maxOccurs="1" name="CreditTiers" type="ArrayOfCreditTierItem" />
      <xs:element minOccurs="0" maxOccurs="1" name="ActiveTier" type="xs:string" />
      <xs:element minOccurs="0" maxOccurs="1" name="RatePrograms" type="ArrayOfRateProgram" />
      <xs:element minOccurs="0" maxOccurs="1" name="ResidualPrograms" type="ArrayOfResidualProgram" />
      <xs:element minOccurs="1" maxOccurs="1" name="RebateAmount" type="xs:double" />
      <xs:element minOccurs="0" maxOccurs="1" name="SerializedDealerCash" type="ArrayOfDealerCashTerm" />
      <xs:element minOccurs="0" maxOccurs="1" name="AllowIncentives" type="xs:string" />
      <xs:element minOccurs="0" maxOccurs="1" name="DealerOptionCalcMethod" type="xs:string" />
      <xs:element minOccurs="0" maxOccurs="1" name="LenderTradeTaxCredit" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="IgnoreInitialMiles" type="xs:boolean" />
      <xs:element minOccurs="1" maxOccurs="1" name="RebateUsage" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="DealerCashUsage" type="xs:string" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="ProgramWithIncentives" >
    <xs:complexContent>
      <xs:extension base="Program">
        <xs:sequence>
          <xs:element minOccurs="1" maxOccurs="1" name="Incentives" type="ArrayOfProgramIncentive" />
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>
  <xs:complexType name="ArrayOfProgramIncentive" >
    <xs:sequence>
      <xs:element minOccurs="0" maxOccurs="unbounded" name="ProgramIncentive" nillable="true" type="ProgramIncentive" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="ProgramIncentive" >
    <xs:sequence>
      <xs:element minOccurs="1" maxOccurs="1" name="IncId" type="xs:int" />
      <xs:element minOccurs="1" maxOccurs="1" name="IncName" type="xs:string" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="ArrayOfCreditTierItem" >
    <xs:sequence>
      <xs:element minOccurs="0" maxOccurs="unbounded" name="CreditTierItem" nillable="true" type="CreditTierItem" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="CreditTierItem" >
    <xs:sequence>
      <xs:element minOccurs="0" maxOccurs="1" name="Description" type="xs:string" />
      <xs:element minOccurs="1" maxOccurs="1" name="MinimumScore" type="xs:int" />
      <xs:element minOccurs="1" maxOccurs="1" name="Quote" type="xs:boolean" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="ArrayOfRateProgram" >
    <xs:sequence>
      <xs:element minOccurs="0" maxOccurs="unbounded" name="RateProgram" nillable="true" type="RateProgram" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="RateProgram" >
    <xs:complexContent mixed="false">
      <xs:extension base="RateProgramAdjustment">
        <xs:sequence>
          <xs:element minOccurs="1" maxOccurs="1" name="Active" type="xs:boolean" />
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>
  <xs:complexType name="RateProgramAdjustment" >
    <xs:complexContent mixed="false">
      <xs:extension base="BaseProgramAdjustment">
        <xs:sequence>
          <xs:element minOccurs="1" maxOccurs="1" name="RequiredComponents" type="xs:string" />
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>
  <xs:complexType name="BaseProgramAdjustment" abstract="true">
    <xs:complexContent mixed="false">
      <xs:extension base="IntStringPair">
        <xs:sequence>
          <xs:element minOccurs="1" maxOccurs="1" name="LenderSpecific" type="xs:boolean" />
          <xs:element minOccurs="0" maxOccurs="1" name="LongDescription" type="xs:string" />
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>
  <xs:complexType name="IntStringPair" >
    <xs:sequence>
      <xs:element minOccurs="1" maxOccurs="1" name="Id" type="xs:int" />
      <xs:element minOccurs="0" maxOccurs="1" name="Description" type="xs:string" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="ResidualProgramAdjustment" >
    <xs:complexContent mixed="false">
      <xs:extension base="BaseProgramAdjustment">
        <xs:sequence>
          <xs:element minOccurs="1" maxOccurs="1" name="ResidualAdjustmentType" type="xs:int" />
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>
  <xs:complexType name="ResidualProgram" >
    <xs:complexContent mixed="false">
      <xs:extension base="ResidualProgramAdjustment">
        <xs:sequence>
          <xs:element minOccurs="1" maxOccurs="1" name="Active" type="xs:boolean" />
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>
  <xs:complexType name="ArrayOfResidualProgram" >
    <xs:sequence>
      <xs:element minOccurs="0" maxOccurs="unbounded" name="ResidualProgram" nillable="true" type="ResidualProgram" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="ArrayOfDealerCashTerm" >
    <xs:sequence>
      <xs:element minOccurs="0" maxOccurs="unbounded" name="DealerCashTerm" nillable="true" type="DealerCashTerm" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="DealerCashTerm" >
    <xs:sequence>
      <xs:element minOccurs="1" maxOccurs="1" name="KeyTerm" type="xs:int" />
      <xs:element minOccurs="1" maxOccurs="1" name="MinimumTerm" type="xs:int" />
      <xs:element minOccurs="1" maxOccurs="1" name="MaximumTerm" type="xs:int" />
      <xs:element minOccurs="1" maxOccurs="1" name="Amount" type="xs:double" />
    </xs:sequence>
  </xs:complexType>
</xs:schema>',
LOCAL=>FALSE,
GENTYPES=>TRUE,
GENTABLES=>TRUE,
FORCE=>FALSE
);
END;
/
SHOW ERRORS

