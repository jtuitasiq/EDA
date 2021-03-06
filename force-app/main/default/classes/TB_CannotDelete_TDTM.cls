/*
    Copyright (c) 2020, Salesforce.org
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Salesforce.org nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
 
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
    POSSIBILITY OF SUCH DAMAGE.
*/
/**
* @author Salesforce.org
* @date 2020
* @group Time Blocks
* @group-content ../../ApexDocContent/TimeBlocks.htm
* @description Stops a Time Block from being deleted if it associated with
* any Course Offering or Course Offering Schedule child records. 
*/

public with sharing class TB_CannotDelete_TDTM extends TDTM_runnable {

    /*******************************************************************************************************
    * @description Get the setting for Prevent Time Block Deletion
    */
    private static Boolean enabledPreventTimeBlockDeletion = UTIL_CustomSettingsFacade.getSettings().Prevent_Time_Block_Deletion__c;
    
    /*******************************************************************************************************
    * @description Stops a Time Block from being deleted if it has any Course Offering or 
    * Course Offering Schedule child records. 
    * @param newlist the list of Tests from trigger new. 
    * @param oldlist the list of Tests from trigger old. 
    * @param triggerAction which trigger event (BeforeInsert, AfterInsert, etc.). 
    * @param objResult the describe for Time Blocks. 
    * @return DmlWrapper.  
    ********************************************************************************************************/
    public override DmlWrapper run(List<SObject> newlist, List<SObject> oldlist, 
    TDTM_Runnable.Action triggerAction, Schema.DescribeSObjectResult objResult) {
        
        if (TB_CannotDelete_TDTM.enabledPreventTimeBlockDeletion == FALSE) {
            return new DmlWrapper(); 
        }
        
        Map<Id, Time_Block__c> oldmap = new Map<Id, Time_Block__c>((List<Time_Block__c>)oldList);
        
        if (triggerAction == TDTM_Runnable.Action.BeforeDelete) {
            for (Time_Block__c tb : [ SELECT Id, 
                                        (SELECT Id FROM Time_Block__c.Time_Blocks__r LIMIT 1),
                                        (SELECT Id FROM Time_Block__c.Course_Offering_Schedules__r LIMIT 1)
                                      FROM Time_Block__c WHERE Id IN :oldlist
                                    ]) {
                
                if (this.hasChildRecords(tb)) {
                    Time_Block__c timeBlockInContext = oldMap.get(tb.ID);
                    timeBlockInContext.addError(Label.CannotDelete);
                }
            }     
        }
        
        return new DmlWrapper();
    }
    
    /*******************************************************************************************************
     * @description Evaluates whether the Time Block has any child (Course Offering or 
     * Course Offering Schedule) related records.
     * @param tb is the current Time Block record.
     * @return Boolean.
     ********************************************************************************************************/
    @testVisible
    private Boolean hasChildRecords(Time_Block__c tb) {
        return ( tb.Time_Blocks__r.isEmpty() == FALSE || tb.Course_Offering_Schedules__r.isEmpty() == FALSE ); 
    }
}