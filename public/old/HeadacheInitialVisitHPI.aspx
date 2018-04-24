<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HeadacheInitialVisitHPI.aspx.cs" Inherits="Medical_Headache" Title="Headache" %>
<%@ MasterType TypeName="MasterPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register assembly="CuteEditor" namespace="CuteEditor" tagprefix="CE" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
                          <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                        AssociatedUpdatePanelID="UpdatePanel1" 
        DynamicLayout="False">
                        <ProgressTemplate>
                            <table align="center" class="style2">
                                <tr>
                                    <td style="text-align: center">
                                        <asp:Image ID="imageProcessingUpdate" runat="server" 
                                            AlternateText="Processing!" ImageAlign="Middle" 
                                            ImageUrl="~/Images/Processing.gif" />
                                    </td>
                                </tr>
                            </table>
                        </ProgressTemplate>
                    </asp:UpdateProgress>


    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>      




        <br />
            <table>
                <tr>
                    <td>
                        <asp:SqlDataSource ID="sqlDataSourceListOfEncounters" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                            
                            
                            
                            SelectCommand="SELECT EncounterID, AppointmentDateTime FROM kn_Encounter WHERE (PatientID = @patientID) AND (AppointmentStatusID = 1) AND (MedicalRecordsLocked = 0) ORDER BY AppointmentDateTime DESC">
                            <SelectParameters>
                             <asp:ProfileParameter Name="PatientID" PropertyName="PatientID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label ID="labelListOfEncounters" runat="server" ForeColor="Blue" 
                            Text="Encounter Date" Enabled="False"></asp:Label>
&nbsp;<asp:DropDownList ID="dropDownListOfEncounters" runat="server" 
                            DataSourceID="sqlDataSourceListOfEncounters" 
                            DataTextField="AppointmentDateTime" DataValueField="EncounterID" 
                            AutoPostBack="True" Enabled="False" 
                            ondatabound="dropDownListOfEncounters_DataBound" 
                            onselectedindexchanged="dropDownListOfEncounters_SelectedIndexChanged">
                        </asp:DropDownList>
                    <br />
                    <asp:Label ID="labelDateWarning" runat="server" BackColor="Yellow" 
                            BorderColor="Blue" BorderStyle="Solid" BorderWidth="1px" ForeColor="Red" 
                            Visible="False">Selected Encounter Date is NOT Today&#39;s Date!</asp:Label>
                    </td>
                </tr>
    </table>

    <br />

    <asp:MultiView ID="mvHeadache" runat="server" ActiveViewIndex="0" Visible="False">
        <asp:View ID="viewHistoryProvidedBy" runat="server">
            
            
            <asp:Label ID="Label44" runat="server" Text="Common Relationships"></asp:Label>
            <asp:SqlDataSource ID="sqlDataSourceRelationships" runat="server">
            </asp:SqlDataSource>
            <asp:CheckBoxList ID="checkBoxListRelationships" runat="server" 
                RepeatColumns="4">
                <asp:ListItem>mother</asp:ListItem>
                <asp:ListItem>father</asp:ListItem>
                <asp:ListItem>grandmother</asp:ListItem>
                <asp:ListItem>grandfather</asp:ListItem>
                <asp:ListItem>aunt</asp:ListItem>
                <asp:ListItem>uncle</asp:ListItem>
                <asp:ListItem>guardian</asp:ListItem>
                <asp:ListItem>foster mother</asp:ListItem>
                <asp:ListItem>foster father</asp:ListItem>
                <asp:ListItem>case worker</asp:ListItem>
                <asp:ListItem>DCF agent</asp:ListItem>
                <asp:ListItem>brother</asp:ListItem>
                <asp:ListItem>sister</asp:ListItem>
            </asp:CheckBoxList>
            <br />
            
            
            <asp:Button ID="buttonProcessRelationship" runat="server" 
                CausesValidation="False" onclick="buttonProcessRelationship_Click" 
                Text="Select Relationship" UseSubmitBehavior="False" />
            <br />
            <br />
            
            
            <br />
            <asp:Label ID="Label43" runat="server" ForeColor="Blue" 
                Text="Relationship to Child"></asp:Label>
            &nbsp;
            <br />
            <asp:TextBox ID="textBoxRelationship" runat="server" Height="50px" 
                TextMode="MultiLine" Width="400px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" 
                ControlToValidate="textBoxRelationship" 
                ErrorMessage="Required.  You must provide the relationship of the person  giving this history."></asp:RequiredFieldValidator>
            <br />
            <br />
            <br />
            <asp:Label ID="Label46" runat="server" ForeColor="Blue" 
                Text="Past history is significant for"></asp:Label>
            <br />
            <asp:TextBox ID="textBoxPastHistorySignificantFor" runat="server" 
                Height="150px" TextMode="MultiLine" Width="500px"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button22" runat="server" CommandName="NextView" Text="Next" />
        </asp:View>
        

        
        <asp:View ID="viewDuration" runat="server">
            <br />
        <asp:Button ID="Button1" runat="server" CommandName="PrevView" Text="Previous" Width="80px" />
        <asp:Button ID="Button2" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />
            How long has the patient had headaches?<br />
            <asp:RadioButtonList ID="radioButtonListDuration" runat="server">
                <asp:ListItem>1 day</asp:ListItem>
                <asp:ListItem>2 days</asp:ListItem>
                <asp:ListItem>3 days</asp:ListItem>
                <asp:ListItem>4 days</asp:ListItem>
                <asp:ListItem>5 days</asp:ListItem>
                <asp:ListItem>6 days</asp:ListItem>
                <asp:ListItem>1 week</asp:ListItem>
                <asp:ListItem>2 weeks</asp:ListItem>
                <asp:ListItem>3 weeks</asp:ListItem>
                <asp:ListItem>1 month</asp:ListItem>
                <asp:ListItem>less than six months</asp:ListItem>
                <asp:ListItem>more than six months, but less than a year</asp:ListItem>
                <asp:ListItem>a few years</asp:ListItem>
                <asp:ListItem>several years</asp:ListItem>
            </asp:RadioButtonList>
            &nbsp;&nbsp;
        </asp:View>

        <asp:View ID="viewKindsOfHeadaches" runat="server"><asp:Button ID="Button21" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button23" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />
            How many different kinds of headaches does the patient have?&nbsp; Do all headaches
            have the same level of severity, affect the same area of the head, and cause similar
            symptoms?<br />
            <asp:RadioButtonList ID="radioButtonListKindsOfHeadaches" runat="server">
                <asp:ListItem>one kind</asp:ListItem>
                <asp:ListItem>two different kinds</asp:ListItem>
                <asp:ListItem>many different kinds</asp:ListItem>
            </asp:RadioButtonList><br />
        </asp:View>


        <asp:View ID="viewLocation" runat="server"><asp:Button ID="Button3" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button4" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" />
            <br />
            <br />
            Where is the headache located?<asp:CheckBoxList ID="checkBoxListLocation" 
                runat="server">
            <asp:ListItem Value="generalized">all over</asp:ListItem>
            <asp:ListItem Value="frontal">forehead</asp:ListItem>
            <asp:ListItem Value="temporal">temples</asp:ListItem>
            <asp:ListItem Value="orbital">behind the eyes</asp:ListItem>
            <asp:ListItem Value="occipital">back of the head</asp:ListItem>
            <asp:ListItem Value="right hemicranial">right side of head</asp:ListItem>
            <asp:ListItem Value="left hemicranial">left side of head</asp:ListItem>
            <asp:ListItem>neck</asp:ListItem>
            </asp:CheckBoxList><br />
            &nbsp;</asp:View>
        <asp:View ID="viewProgression" runat="server"><asp:Button ID="Button25" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button26" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />
            Over time, the headache has:<br />
            <asp:RadioButtonList ID="radioButtonListProgression" runat="server" 
                RepeatDirection="Horizontal" AutoPostBack="True" 
                onselectedindexchanged="radioButtonListProgression_SelectedIndexChanged">
                <asp:ListItem>gotten better</asp:ListItem>
                <asp:ListItem>remained the same</asp:ListItem>
                <asp:ListItem>gotten worse</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <asp:RadioButtonList ID="radioButtonListGottenWorse" runat="server" 
                RepeatDirection="Horizontal" Visible="False">
                <asp:ListItem>increased in severity</asp:ListItem>
                <asp:ListItem>increased in frequency</asp:ListItem>
                <asp:ListItem>increased in severity and frequency</asp:ListItem>
            </asp:RadioButtonList>
            <asp:TextBox ID="textBoxGottenWorseSinceWhen" runat="server" Visible="False" 
                Width="300px"></asp:TextBox>
            <cc1:TextBoxWatermarkExtender ID="textBoxGottenWorseSinceWhen_TextBoxWatermarkExtender" 
                runat="server" Enabled="True" TargetControlID="textBoxGottenWorseSinceWhen" 
                WatermarkText="(e.g. four days)">
            </cc1:TextBoxWatermarkExtender>
            &nbsp;<br />
            <br />
            <br />
        </asp:View>
        <asp:View ID="viewSeverity" runat="server"><asp:Button ID="Button5" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button6" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />

            <br />
            Headace worsens with:<br />
            <asp:CheckBoxList ID="checkBoxListHeadaceWorsensWith" runat="server" 
                RepeatDirection="Horizontal">
                            <asp:ListItem>activity</asp:ListItem>
                            <asp:ListItem>standing</asp:ListItem>
                            <asp:ListItem>lying</asp:ListItem>
            </asp:CheckBoxList>                
            <br />
            <br />
            How severe are your headaches?
            <asp:RadioButtonList ID="radioButtonListSeverity" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem>mild</asp:ListItem>
                <asp:ListItem>moderate</asp:ListItem>
                <asp:ListItem>severe</asp:ListItem>
                <asp:ListItem>very severe</asp:ListItem>
            </asp:RadioButtonList>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Label27" runat="server" Text="Mild"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButtonList ID="radioButtonListSeverityScale" runat="server" 
                            RepeatDirection="Horizontal">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                            <asp:ListItem>6</asp:ListItem>
                            <asp:ListItem>7</asp:ListItem>
                            <asp:ListItem>8</asp:ListItem>
                            <asp:ListItem>9</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td>
                        <asp:Label ID="Label28" runat="server" Text="Very Severe"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
        </asp:View>
        <asp:View ID="viewNature" runat="server">
            <asp:Button ID="Button7" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button8" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />
            What does the headache feel like?<br />
            <asp:CheckBoxList ID="checkBoxListNature" runat="server">
                <asp:ListItem>throbbing</asp:ListItem>
                <asp:ListItem>crushing</asp:ListItem>
                <asp:ListItem>band-like</asp:ListItem>
                <asp:ListItem>stabbing</asp:ListItem>
                <asp:ListItem>sharp</asp:ListItem>
                <asp:ListItem>dull</asp:ListItem>
            </asp:CheckBoxList><br />
        </asp:View>
        <asp:View ID="viewFrequency" runat="server">
            <asp:Button ID="Button9" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button10" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />
            How frequent are the headaches?<br />
            <asp:RadioButtonList ID="radioButtonListFrequency" runat="server">
                <asp:ListItem>only once</asp:ListItem>
                <asp:ListItem>several times a day</asp:ListItem>
                <asp:ListItem>once a day</asp:ListItem>
                <asp:ListItem>every other day</asp:ListItem>
                <asp:ListItem>two to three times a week</asp:ListItem>
                <asp:ListItem>once a week</asp:ListItem>
                <asp:ListItem>a few times a month</asp:ListItem>
                <asp:ListItem>once a month</asp:ListItem>
                <asp:ListItem>a few times a year</asp:ListItem>
                <asp:ListItem>about once a year</asp:ListItem>
            </asp:RadioButtonList>&nbsp;
        </asp:View>
        <asp:View ID="viewTiming" runat="server">
            <asp:Button ID="Button11" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button12" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />
            What time of the day do the headaches usually occur?<br />
            <asp:CheckBoxList ID="checkBoxListTiming" runat="server">
                <asp:ListItem>upon awakening</asp:ListItem>
                <asp:ListItem>in the morning</asp:ListItem>
                <asp:ListItem>in the afternoon</asp:ListItem>
                <asp:ListItem>at nighttime</asp:ListItem>
            </asp:CheckBoxList>
            <br />
            Does the headache wake the patient up from sleep?<br />
            <asp:RadioButtonList ID="radioButtonListWakeUpFromSleep" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem>yes</asp:ListItem>
                <asp:ListItem>no</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Does the the patient have vomiting upon awakening?<br />
            <asp:RadioButtonList ID="radioButtonListVomitingUponAwakening" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem>yes</asp:ListItem>
                <asp:ListItem>no</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Does the the patient have an aura associated with the headache?<br />
            <asp:RadioButtonList ID="radioButtonListAuraHeadache" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem>yes</asp:ListItem>
                <asp:ListItem>no</asp:ListItem>
            </asp:RadioButtonList>
            <br />
        </asp:View>
        <asp:View ID="viewAssociatedFactors" runat="server">
            <asp:Button ID="Button13" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button14" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />
            Patient reports:<br />
            <asp:CheckBoxList ID="checkBoxListAssociatedFactors" runat="server" 
                RepeatColumns="4">
                <asp:ListItem>nausea</asp:ListItem>
                <asp:ListItem>no nausea</asp:ListItem>
                <asp:ListItem>vomiting</asp:ListItem>
                <asp:ListItem>no vomiting</asp:ListItem>
                <asp:ListItem Value="photophobia">light sensitivity</asp:ListItem>
                <asp:ListItem Value="no photophobia">no light sensitivity</asp:ListItem>
                <asp:ListItem Value="phonophobia">sound sensitivity</asp:ListItem>
                <asp:ListItem Value="no phonophobia">no sound sensitivity</asp:ListItem>
                <asp:ListItem>loss of vision</asp:ListItem>
                <asp:ListItem>weakness</asp:ListItem>
                <asp:ListItem Value="hemiplegia">paralysis of one side</asp:ListItem>
                <asp:ListItem Value="no hemiplegia">no paralysis of one side</asp:ListItem>
                <asp:ListItem Value="ophthalmoplegia">inability to move eyes</asp:ListItem>
                <asp:ListItem Value="no ophthalmoplegia">no difficulty in moving eyes</asp:ListItem>
                <asp:ListItem Value="nystagmus">eye shaking</asp:ListItem>
                <asp:ListItem Value="dysphagia">difficulty in eating or swallowing</asp:ListItem>
                <asp:ListItem Value="no dysphagia">no difficulty in eating or swallowing</asp:ListItem>
                <asp:ListItem Value="diplopia">double vision</asp:ListItem>
                <asp:ListItem Value="no diplopia">no double vision</asp:ListItem>
                <asp:ListItem Value="paresthesia">tingling numbness</asp:ListItem>
                <asp:ListItem Value="vertigo">vertigo</asp:ListItem>
                <asp:ListItem Value="no vertigo">no vertigo</asp:ListItem>
                <asp:ListItem>dizziness</asp:ListItem>
                <asp:ListItem Value="dysarthria">difficulty in talking</asp:ListItem>
                <asp:ListItem Value="no dysarthria">no difficulty in talking</asp:ListItem>
                <asp:ListItem>fever</asp:ListItem>
                <asp:ListItem>no fever</asp:ListItem>
                <asp:ListItem>head trauma</asp:ListItem>
                <asp:ListItem>no head trauma</asp:ListItem>
                <asp:ListItem>history of travel outside of the country</asp:ListItem>
                <asp:ListItem>no history of travel outside of the country</asp:ListItem>
                <asp:ListItem>neck pain/stiffness</asp:ListItem>
                <asp:ListItem>no neck pain or stiffness</asp:ListItem>
                <asp:ListItem>staring spells</asp:ListItem>
                <asp:ListItem>no staring spells</asp:ListItem>
                <asp:ListItem>history of seizures</asp:ListItem>
                <asp:ListItem>no history of seizures</asp:ListItem>
            </asp:CheckBoxList><br />
        </asp:View>
        <asp:View ID="viewGeneral1" runat="server">
            <asp:Button ID="Button15" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button16" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            &nbsp;<br />
            <br />
            What does the patient do when a headache occurs?<br />
            <asp:CheckBoxList ID="checkBoxListTreatment" runat="server">
                <asp:ListItem>lies down</asp:ListItem>
                <asp:ListItem>makes room dark and quiet</asp:ListItem>
                <asp:ListItem>covers eyes</asp:ListItem>
                <asp:ListItem>takes pain-killers such as Motrin or Tylenol</asp:ListItem>
            </asp:CheckBoxList><br />

            How frequently does the patient take pain-killers like Aspirin, Tylenol, or Motrin?<br />
            <asp:RadioButtonList ID="radioButtonListPainKillers" runat="server" 
                Width="220px">
                <asp:ListItem>taken several times a day</asp:ListItem>
                <asp:ListItem>taken once a day</asp:ListItem>
                <asp:ListItem>taken two to three times a week</asp:ListItem>
                <asp:ListItem>taken once a week or less</asp:ListItem>
                <asp:ListItem>never taken</asp:ListItem>
            </asp:RadioButtonList><br />

            Does sleeping resolve the headache?<br />
            <asp:RadioButtonList ID="radioButtonListSleeping" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem Value="resolves">Yes</asp:ListItem>
                <asp:ListItem Value="does not resolve">No</asp:ListItem>
                <asp:ListItem Value="sometimes resolves">Sometimes</asp:ListItem>
            </asp:RadioButtonList><br />

            Does the patient look ill during headaches?<asp:RadioButtonList ID="radioButtonListIll"
                runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="looks">Yes</asp:ListItem>
                <asp:ListItem Value="does not look">No</asp:ListItem>
                <asp:ListItem Value="sometimes looks">Sometimes</asp:ListItem>
            </asp:RadioButtonList><br />
            Does the patient have loss of appetite during headaches?<asp:RadioButtonList ID="radioButtonListAppetite"
                runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="cause">Yes</asp:ListItem>
                <asp:ListItem Value="do not cause">No</asp:ListItem>
                <asp:ListItem Value="sometimes cause">Sometimes</asp:ListItem>
            </asp:RadioButtonList><br />
            Does the patient have a history of allergies?<br />
            <asp:RadioButtonList ID="radioButtonListAllergies" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem Value="has">Yes</asp:ListItem>
                <asp:ListItem Value="does not have">No</asp:ListItem>
            </asp:RadioButtonList><br />
            Does the patient skip meals?<br />
            <asp:RadioButtonList ID="radioButtonListMeals" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem Value="skips">Yes</asp:ListItem>
                <asp:ListItem Value="does not skip">No</asp:ListItem>
                <asp:ListItem Value="sometimes skips">Sometimes</asp:ListItem>
            </asp:RadioButtonList><br />
            Has the vision been checked in the last six months?<br />
            <asp:RadioButton ID="radioButtonVisionYes" runat="server" 
                GroupName="groupRadioVision" Text="Yes" /><asp:RadioButton
                ID="radioButtonVisionNo" runat="server" GroupName="groupRadioVision" 
                Text="No" />&nbsp;<cc1:CollapsiblePanelExtender
                    ID="CollapsiblePanelExtenderGlassesPrescribed" runat="server" CollapseControlID="radioButtonVisionNo"
                    Collapsed="True" ExpandControlID="radioButtonVisionYes" TargetControlID="panelEyeGlasses"></cc1:CollapsiblePanelExtender><br />
            <asp:Panel ID="panelEyeGlasses" runat="server" Height="50px" Width="335px">
                <br />
                Were glasses/contact lenses prescribed?<br />
                <asp:RadioButton ID="radioButtonGlassesYes" runat="server" 
                    GroupName="groupRadioGlassesPrescribed" Text="Yes" /><asp:RadioButton
                ID="radioButtonGlassesNo" runat="server" GroupName="groupRadioGlassesPrescribed" 
                    Text="No" /><br />
                <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtenderWearsGlasses" runat="server"
                    CollapseControlID="radioButtonGlassesNo" Collapsed="True" ExpandControlID="radioButtonGlassesYes"
                    TargetControlID="panelWearsGlasses"></cc1:CollapsiblePanelExtender>
                <asp:Panel ID="panelWearsGlasses" runat="server" Height="50px" Width="337px">
                    <br />
            Is the patient wearing glasses/contact lenses regularly?<asp:RadioButtonList 
                        ID="radioButtonListWearsGlasses" runat="server" RepeatDirection="Horizontal" 
                        ForeColor="Black">
                <asp:ListItem Value="wears">Yes</asp:ListItem>
                <asp:ListItem Value="does not wear">No</asp:ListItem>
            </asp:RadioButtonList>
                </asp:Panel>
            </asp:Panel>
            <br />
            Does the patient have a history of snoring?<br />
            &nbsp;<asp:RadioButton ID="radioButtonSnoringYes" runat="server" GroupName="groupRadioSnoring"
                Text="Yes" />
            <asp:RadioButton ID="radioButtonSnoringNo" runat="server" 
                GroupName="groupRadioSnoring" Text="No" />
            <br />
            <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtenderBreathing" runat="server" CollapseControlID="radioButtonSnoringNo"
                Collapsed="True" ExpandControlID="radioButtonSnoringYes" TargetControlID="panelSnoring"></cc1:CollapsiblePanelExtender>
            <br />
            <asp:Panel ID="panelSnoring" runat="server" Height="50px" Width="382px">
                Does the patient wake up due to difficulty in breathing?<br />
            <asp:RadioButtonList ID="radioButtonListBreathing" runat="server" 
                    RepeatDirection="Horizontal" ForeColor="Black">
                <asp:ListItem Value="Snoring causes difficulty in breathing and wakes patient up at night.  ">Yes</asp:ListItem>
                <asp:ListItem Value="Snoring does not cause difficulty in breathing or wake patient up at night.  ">No</asp:ListItem>
                <asp:ListItem Value="Snoring sometimes causes difficulty in breathing and wakes patient up at night.  ">Sometimes</asp:ListItem>
            </asp:RadioButtonList><br />
            </asp:Panel>
        </asp:View>
        <asp:View ID="viewGeneral2" runat="server">
            <asp:Button ID="Button17" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button18" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            
            <br />
            
            Does the patient consume:<br />
            <asp:CheckBoxList ID="checkBoxListFood" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem>sodas (caffeinated)</asp:ListItem>
                <asp:ListItem>coffee</asp:ListItem>
                <asp:ListItem>tea</asp:ListItem>
                <asp:ListItem>chocolate</asp:ListItem>
                <asp:ListItem>smoked meats</asp:ListItem>
            </asp:CheckBoxList>
            <br />
            Has the patient missed school due to headache?<br />
            <asp:RadioButtonList 
                ID="radioButtonListMissedSchool" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="0">never missed school due to headache</asp:ListItem>
                <asp:ListItem Value="1">missed a few days of school</asp:ListItem>
                <asp:ListItem Value="2">missed a few weeks of school</asp:ListItem>
                <asp:ListItem Value="3">patient is homebound due to headaches</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Patient has recently taken:<br />
            <asp:CheckBoxList ID="checkBoxListVitaminsSteroids" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem>vitamins</asp:ListItem>
                <asp:ListItem>steroids</asp:ListItem>
            </asp:CheckBoxList>
            <br />
            Does the patient have history of sinus infections?<br />
            <asp:RadioButtonList ID="radioButtonListSinus" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Does the patient have trouble falling asleep?<br />
            <asp:RadioButtonList ID="radioButtonListFallingAsleep" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Does the patient have trouble maintaining sleep?<br />
            <asp:RadioButtonList ID="radioButtonListMaintainingSleep" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Does the patient have history of illicit drug use?<br />
            <asp:RadioButtonList 
                ID="radioButtonListDrugAbuse" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Does the patient have history of diffused body aches and pains?<br />
            <asp:RadioButtonList 
                ID="radioButtonListDiffusedBodyAchesPain" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Does the patient have history of depression?<br />
            <asp:RadioButtonList 
                ID="radioButtonListDepression" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Does the patient have a history of thyroid problems?<br />
            <asp:RadioButtonList 
                ID="radioButtonListThyroidProblems" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Has there been a change in the patient's weight?<br />
            <asp:RadioButtonList 
                ID="radioButtonListWeightChange" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="0">No change in weight</asp:ListItem>
                <asp:ListItem Value="1">Weight Gain</asp:ListItem>
                <asp:ListItem Value="2">Weight Loss (Due to Dieting)</asp:ListItem>
                <asp:ListItem Value="3">Weight Loss (NOT Due to Dieting)</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <br />
            <br />

       </asp:View>

        <asp:View ID="viewFamilyHistory" runat="server">
            <br />
        <asp:Button ID="Button29" runat="server" CommandName="PrevView" Text="Previous" Width="80px" />
        <asp:Button ID="Button30" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />
            Family History of Migraine<br />
            <asp:CheckBoxList ID="checkBoxListFamilyHistoryMigraine" runat="server" 
                RepeatDirection="Horizontal" RepeatColumns="2">
                <asp:ListItem>mother</asp:ListItem>
                <asp:ListItem>father</asp:ListItem>
                <asp:ListItem>sister(s)</asp:ListItem>
                <asp:ListItem>brother(s)</asp:ListItem>
                <asp:ListItem>maternal grandmother</asp:ListItem>
                <asp:ListItem>paternal grandmother</asp:ListItem>
                <asp:ListItem>maternal grandfather</asp:ListItem>
                <asp:ListItem>paternal grandfather</asp:ListItem>
                <asp:ListItem>maternal aunt(s)</asp:ListItem>
                <asp:ListItem>maternal uncle(s)</asp:ListItem>
                <asp:ListItem>paternal aunt(s)</asp:ListItem>
                <asp:ListItem>paternal uncle(s)</asp:ListItem>
            </asp:CheckBoxList>
            &nbsp;&nbsp;
        
            <br />
            Family history of Aneurysm<br />
            <asp:RadioButtonList ID="radioButtonListFamilyHistoryAneurysm" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
        
            <br />
            Family history of Seizures<br />
            <asp:RadioButtonList ID="radioButtonListFamilyHistorySeizures" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
        
            <br />
            Family history of Thyroid problems<br />
            <asp:RadioButtonList ID="radioButtonListFamilyHistoryThyroidProblems" runat="server" 
                RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:RadioButtonList>
        
        
        </asp:View>
        
          
        <asp:View ID="viewPreventiveMedications" runat="server"><asp:Button ID="Button20" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button24" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />

            <asp:SqlDataSource ID="sqlDataSourceMedicationRoute" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [Route] FROM [kn_Medical_MedicationRoute] ORDER BY [SortOrder]">
            </asp:SqlDataSource>
            
            <asp:SqlDataSource ID="sqlDataSourceMedicationFrequency" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [Frequency] FROM [kn_Medical_MedicationFrequency] ORDER BY [SortOrder]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlDataSourceMedicationDuration" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [Duration] FROM [kn_Medical_MedicationDuration] ORDER BY [SortOrder]">
            </asp:SqlDataSource>
            <br />

            <asp:Label ID="Label1" runat="server" Text="Has the patient ever taken or is currently taking any of the following preventive medications for headaches?"></asp:Label><br />
            <div style="text-align: left">
    <br />
                <table>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxPropranolol" runat="server" Text="Propranolol" /></td>
                        <td>
            <asp:Panel ID="panelPropranolol" BorderStyle= "None" runat="server">
                <br />
                <asp:Label ID="Label4" runat="server" Text="Was Propranolol effective at resolving the headache?"> </asp:Label>
                <asp:RadioButtonList ID="radioButtonListPropranololEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                </asp:RadioButtonList>  
                </asp:Panel>
                
                
                
                
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxPeriactin" runat="server" Text="Periactin" /></td>
                        <td>
            <asp:Panel ID="panelPeriactin" runat="server" Wrap="False">
                <br />
                Was 
            Periactin effective at resolving the headache? &nbsp;
                <asp:RadioButtonList ID="radioButtonListPeriactin" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxElavil" runat="server" Text="Elavil" /></td>
                        <td>
            <asp:Panel ID="panelElavil" runat="server" Wrap="False">
                <br />
                Was Elavil effective at resolving the headache? &nbsp;
                <asp:RadioButtonList ID="radioButtonListElavil" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxTopamax" runat="server" Text="Topamax" /></td>
                        <td>
            <asp:Panel ID="panelTopamax" runat="server" Wrap="False">
                <br />
                Was 
            Topamax effective at resolving the headache? &nbsp;
                <asp:RadioButtonList ID="radioButtonListTopamax" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="has">Yes</asp:ListItem>
                    <asp:ListItem Value="has NOT">No</asp:ListItem>
                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxDepakote" runat="server" Text="Depakote" /></td>
                        <td>
            <asp:Panel ID="panelDepakote" runat="server" Wrap="False">
                <br />
                Was 
            Depakote effective at resolving the headache? &nbsp;
                <asp:RadioButtonList ID="radioButtonListDepakote" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxOtherPreventiveMedication" runat="server" Text="Other" /></td>
                        <td>
                            <asp:Panel ID="panelOtherPreventiveMedication" runat="server" Wrap="False">
                                <br />
                                <asp:Label ID="Label3" runat="server" Text="Please enter the name(s) of other preventive medications taken for headache."></asp:Label><br />
                                <asp:TextBox ID="textBoxOtherPreventiveMedication" runat="server" TextMode="MultiLine"  Text = "[Name of Medication], which [was][was NOT] effective at resolving headache; [Name of Medication], which [was][was NOT] effective at resolving headache; and, [Name of Medication], which [was][was NOT] effective at resolving headache" Width="400" Height="200"></asp:TextBox>
                                <br />
                                </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxNoPreventiveMedications" runat="server" Text="None" /></td>
                        <td>
                            <asp:Panel ID="panelNoPreventiveMedications" runat="server" >
                                <br />
                                No preventive medications have previously been taken for headaches.</asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <cc1:CollapsiblePanelExtender ID="cpePropranolol" runat="server" CollapseControlID="checkBoxPropranolol"
                Collapsed="True" ExpandControlID="checkBoxPropranolol" TargetControlID="panelPropranolol"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpePeriactin" runat="server" CollapseControlID="checkBoxPeriactin"
                Collapsed="True" ExpandControlID="checkBoxPeriactin" TargetControlID="panelPeriactin"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeElavil" runat="server" CollapseControlID="checkBoxElavil"
                Collapsed="True" ExpandControlID="checkBoxElavil" TargetControlID="panelElavil"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeTopamax" runat="server" CollapseControlID="checkBoxTopamax"
                Collapsed="True" ExpandControlID="checkBoxTopamax" TargetControlID="panelTopamax"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeDepakote" runat="server" CollapseControlID="checkBoxDepakote"
                Collapsed="True" ExpandControlID="checkBoxDepakote" TargetControlID="panelDepakote"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeOtherPreventiveMedication" runat="server" CollapseControlID="checkBoxOtherPreventiveMedication"
                Collapsed="True" ExpandControlID="checkBoxOtherPreventiveMedication" TargetControlID="panelOtherPreventiveMedication"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeNoPreventiveMedication" runat="server" CollapseControlID="checkBoxNoPreventiveMedications"
                Collapsed="True" ExpandControlID="checkBoxNoPreventiveMedications" TargetControlID="panelNoPreventiveMedications"></cc1:CollapsiblePanelExtender>
            <br />
        </asp:View>  
            
            
     
       
        <asp:View ID="viewOtherPainMedications" runat="server">
        <asp:Button ID="Button27" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button28" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" /><br />
            <br />
            Has the patient ever taken any of the following pain medications for headache?<br />
            <div style="text-align: left">
                <table>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxTylenol" runat="server" Text="Tylenol" /></td>
                        <td>
            <asp:Panel ID="panelTylenol" runat="server" >
                <br />
                Was Tylenol effective at resolving the headache? &nbsp;
                <asp:RadioButtonList ID="radioButtonListTylenolEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxMotrinIbuprofen" runat="server" Text="Motrin/Ibuprofen" /></td>
                        <td>
            <asp:Panel ID="panelMotrinIbuprofen" runat="server" >
                <br />
                Was Motrin/Ibuprofen effective at resolving the headache? &nbsp;
                <asp:RadioButtonList ID="radioButtonListMotrinIbuprofenEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxAleveNaproxen" runat="server" Text="Aleve/Naproxen" /></td>
                        <td>
            <asp:Panel ID="panelAleveNaproxen" runat="server" >
                <br />
                Was Aleve/Naproxen effective at resolving the headache? &nbsp;
                <asp:RadioButtonList ID="radioButtonListAleveNaproxenEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxMidrin" runat="server" Text="Midrin" /></td>
                        <td>
            <asp:Panel ID="panelMidrin" runat="server" >
                <br />
                Was Midrin effective at resolving the headache? &nbsp;
                <asp:RadioButtonList ID="radioButtonListMidrinEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxFioricet" runat="server" Text="Fioricet" /></td>
                        <td>
            <asp:Panel ID="panelFioricet" runat="server">
                <br />
                Was Fioricet effective at resolving the headache?&nbsp;
                <asp:RadioButtonList ID="radioButtonListFioricetEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxZomig" runat="server" Text="Zomig" /></td>
                        <td>
             <asp:Panel ID="panelZomig" runat="server" >
              <br />
                                Was Zomig effective at resolving the headache?<br />
                                <asp:RadioButtonList ID="radioButtonListZomigEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                            </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxImitrex" runat="server" Text="Imitrex" /></td>
                        <td>
                            <asp:Panel ID="panelImitrex" runat="server">
                                <br />
                                Was Imitrex effective at resolving the headache?<br />
                                <asp:RadioButtonList ID="radioButtonListImitrexEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxTylenolIII" runat="server" Text="Tylenol III" /></td>
                        <td>
                            <asp:Panel ID="panelTylenolIII" runat="server">
                                <br />
                                Was Tylenol III effective at resolving the headache?<br />
                                <asp:RadioButtonList ID="radioButtonListTylenolIIIEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxRelpax" runat="server" Text="Relpax" /></td>
                        <td>
                            <asp:Panel ID="panelRelpax" runat="server">
                                <br />
                                Was Relpax effective at resolving the headache?<br />
                                <asp:RadioButtonList ID="radioButtonListRelpaxEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="checkBoxBCPowder" runat="server" Text="B C Powder" /></td>
                        <td>
                            <asp:Panel ID="panelBCPowder" runat="server">
                                <br />
                                Was B C Powder effective at resolving the headache?<br />
                                <asp:RadioButtonList ID="radioButtonListBCPowderEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                            <asp:CheckBox ID="checkBoxErgocaff" runat="server" Text="Ergocaff" /></td>
                        <td style="width: 100px">
                            <asp:Panel ID="panelErgocaff" runat="server" Height="50px" Width="350px">
                                <br />
                                Was Ergocaff effective at resolving the headache?<br />
                                <asp:RadioButtonList ID="radioButtonListErgocaffEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                            <asp:CheckBox ID="checkBoxMigranal" runat="server" Text="Migranal" /></td>
                        <td>
                            <asp:Panel ID="panelMigranal" runat="server" Height="50px" Width="350px">
                                <br />
                                Was Migranal effective at resolving the headache?<br />
                                <asp:RadioButtonList ID="radioButtonListMigranalEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            <asp:CheckBox ID="checkBoxExcedrinMigraine" runat="server" Text="Excedrin Migraine" /></td>
                        <td style="width: 100px">
                            <asp:Panel ID="panelExcedrinMigraine" runat="server" Height="50px" Width="375px">
                                <br />
                                Was Excedrin Migraine effective at resolving the headache?<br />
                                <asp:RadioButtonList ID="radioButtonListExcedrinMigraineEffective" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="was">Yes</asp:ListItem>
                    <asp:ListItem Value="was NOT">No</asp:ListItem>
                                </asp:RadioButtonList></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            <asp:CheckBox ID="checkBoxOtherMedications" runat="server" Text="Other" /></td>
                        <td style="width: 100px">
                            <asp:Panel ID="panelOtherMedications" runat="server" Wrap="False">
                                <br />
                                Please enter the name(s) of other medications taken for headache.<br />
                                <asp:TextBox ID="textBoxOtherMedications" runat="server" TextMode="MultiLine" Width="344px"></asp:TextBox></asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            <asp:CheckBox ID="checkBoxNoMedications" runat="server" Text="None" /></td>
                        <td style="width: 100px">
                            <asp:Panel ID="panelNoMedications" runat="server" Wrap="False">
                                <br />
                                No medication has previously been taken for headaches.</asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            &nbsp; &nbsp;
            <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtenderTylenol" runat="server" CollapseControlID="checkBoxTylenol"
                Collapsed="True" ExpandControlID="checkBoxTylenol" TargetControlID="panelTylenol"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtenderMotrinIbuprofen" runat="server" CollapseControlID="checkBoxMotrinIbuprofen"
                Collapsed="True" ExpandControlID="checkBoxMotrinIbuprofen" TargetControlID="panelMotrinIbuprofen"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtenderAleveNaproxen" runat="server" CollapseControlID="checkBoxAleveNaproxen"
                Collapsed="True" ExpandControlID="checkBoxAleveNaproxen" TargetControlID="panelAleveNaproxen"></cc1:CollapsiblePanelExtender>

            <cc1:CollapsiblePanelExtender ID="cpeMidrin" runat="server" CollapseControlID="checkBoxMidrin"
                Collapsed="True" ExpandControlID="checkBoxMidrin" TargetControlID="panelMidrin"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeFioricet" runat="server" CollapseControlID="checkBoxFioricet"
                Collapsed="True" ExpandControlID="checkBoxFioricet" TargetControlID="panelFioricet"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeZomig" runat="server"
                CollapseControlID="checkBoxZomig" Collapsed="True" ExpandControlID="checkBoxZomig"
                TargetControlID="panelZomig"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeImitrex" runat="server" CollapseControlID="checkBoxImitrex"
                Collapsed="True" ExpandControlID="checkBoxImitrex" TargetControlID="panelImitrex"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeTylenolIII" runat="server" CollapseControlID="checkBoxTylenolIII"
                Collapsed="True" ExpandControlID="checkBoxTylenolIII" TargetControlID="panelTylenolIII"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeRelpax" runat="server" TargetControlID="panelRelpax" CollapseControlID="checkBoxRelpax" Collapsed="True" ExpandControlID="checkBoxRelpax"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeBCPowder" runat="server" TargetControlID="panelBCPowder" CollapseControlID="checkBoxBCPowder" Collapsed="True" ExpandControlID="checkBoxBCPowder"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeErgocaff" runat="server" TargetControlID="panelErgocaff" CollapseControlID="checkBoxErgocaff" Collapsed="True" ExpandControlID="checkBoxErgocaff"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeMigranal" runat="server" TargetControlID="panelMigranal" CollapseControlID="checkBoxMigranal" Collapsed="True" ExpandControlID="checkBoxMigranal"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeExcedrinMigraine" runat="server" TargetControlID="panelExcedrinMigraine" CollapseControlID="checkBoxExcedrinMigraine" Collapsed="True" ExpandControlID="checkBoxExcedrinMigraine"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeOtherMedications" runat="server" CollapseControlID="checkBoxOtherMedications"
                Collapsed="True" ExpandControlID="checkBoxOtherMedications" TargetControlID="panelOtherMedications"></cc1:CollapsiblePanelExtender>
            <cc1:CollapsiblePanelExtender ID="cpeNoMedications" runat="server" CollapseControlID="checkBoxNoMedications"
                Collapsed="True" ExpandControlID="checkBoxNoMedications" TargetControlID="panelNoMedications"></cc1:CollapsiblePanelExtender>
            <br />
            <br />

            <br />
        </asp:View>  
            
            
     
       
        <asp:View ID="viewSummaryQuestions" runat="server">
        <asp:Button ID="Button31" runat="server" CommandName="PrevView" Text="Previous" Width="80px" /><asp:Button ID="Button32" runat="server" AccessKey="n" CommandName="NextView" Text="Next" Width="80px" />
            <br />
            <br />
            Patient history is suggestive of:<br />
            <asp:CheckBoxList ID="checkBoxListPatientHistorySuggestiveOf" runat="server">
                <asp:ListItem>migraine headache</asp:ListItem>
                <asp:ListItem>tension headache</asp:ListItem>
                <asp:ListItem>chronic daily headache</asp:ListItem>
                <asp:ListItem>secondary headache</asp:ListItem>
                <asp:ListItem>pseudotumor cerebri</asp:ListItem>
                <asp:ListItem>post spinal headache</asp:ListItem>
                <asp:ListItem>increased intracranial pressure</asp:ListItem>
            </asp:CheckBoxList>
            <br />
            <br />
            Neurological exam:<br /> &nbsp;&nbsp;
           
            <asp:TextBox ID="textBoxNeurologicalExamShowed" runat="server" Height="100px" 
                TextMode="MultiLine" Width="500px" 
                Text="Neurological exam is non-focal.  "></asp:TextBox>
            <br />
            
            <br />
            I recommend:
            <asp:CheckBoxList ID="checkBoxListRecommend" runat="server">
                <asp:ListItem>monitoring diet (headache diet list provided)</asp:ListItem>
                <asp:ListItem>maintaining a headache log (diary provided, which will be reviewed at the next appointment)</asp:ListItem>                
                <asp:ListItem>non-pharmacological intervention (discussed with patient)</asp:ListItem>
            </asp:CheckBoxList>
            <br />
            <br />
            Prophylaxis treatment would be:
            <asp:CheckBoxList ID="checkBoxListProphylaxisTreatment" runat="server">
                <asp:ListItem>Depakote</asp:ListItem>                
                <asp:ListItem>Elavil</asp:ListItem>
                <asp:ListItem>Topamax</asp:ListItem>
                <asp:ListItem>Propranolol</asp:ListItem>                
            </asp:CheckBoxList>
            <br />
            <br />
            Abortive treatment would be:
            <asp:CheckBoxList ID="checkBoxListAbortiveTreatment" runat="server">
                <asp:ListItem>Motrin</asp:ListItem>
                <asp:ListItem>Tylenol</asp:ListItem>
                <asp:ListItem>Excedrin Migraine</asp:ListItem>                
                <asp:ListItem>Midrin</asp:ListItem>
                <asp:ListItem>Fioricet</asp:ListItem>
                <asp:ListItem>Ultram</asp:ListItem>                
            </asp:CheckBoxList>


        </asp:View>


        <asp:View ID="viewSummary" runat="server">
            <asp:Button ID="Button19" runat="server" CommandName="PrevView" Text="Previous" Width="80px" />
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            <asp:Button ID="buttonCreateReport" runat="server" OnClick="buttonCreateReport_Click"
                Text="Create Report" UseSubmitBehavior="False" />
            &nbsp;
            <asp:Button ID="buttonSaveReport" runat="server" 
                OnClick="buttonSaveReport_Click" Text="Save Report" UseSubmitBehavior="False" />
            <br />
            <br />
            <br />
            <CE:Editor ID="editorReportHPI" runat="server"></CE:Editor>
            <br />
            <br />
            <CE:Editor ID="editorReportSummary" runat="server">
            </CE:Editor>
            <br />
            </asp:View>

    </asp:MultiView><br />
</ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

