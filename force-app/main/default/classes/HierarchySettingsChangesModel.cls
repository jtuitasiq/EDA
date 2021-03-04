/*
    Copyright (c) 2021, Salesforce.org
    All rights reserved.
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this List of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this List of conditions and the following disclaimer in the
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
* @date 2021
* @group 
* @group-content ../../ApexDocContent/EdaSettings.htm
* @description Model to abstract data for changes made to Hierarchy Settings.
*/
public with sharing class HierarchySettingsChangesModel {
    public Map<String, String> settingsSingleValueBySettingsName { get; set; }
    public Map<String, List<String>> settingsListSettingsName { get; set; }


    /**********************************************************************************************************************
    * @description No argument constructor
    * @return A HierarchySettingsChangesModel with empty maps
    **********************************************************************************************************************/
    public HierarchySettingsChangesModel() {
        this.settingsSingleValueBySettingsName = new Map<String, String>();
        this.settingsListSettingsName = new Map<String, List<String>>();

    }

    /**********************************************************************************************************************
    * @description Two parameter constructor
    * @param  settingsSingleValueBySettingsName A map of changed hierarchy settings with single values mapped by name 
    * @param  settingsListSettingsName A map of changed hierarchy settings with collections mapped by name 
    * @return A HierarchySettingsChangesModel with all properties populated
    **********************************************************************************************************************/ 
    public HierarchySettingsChangesModel(
        Map<String, String> settingsSingleValueBySettingsName, 
        Map<String, List<String>> settingsListSettingsName
    ) {
        this.settingsSingleValueBySettingsName = settingsSingleValueBySettingsName;
        this.settingsListSettingsName = settingsListSettingsName;
    }
}