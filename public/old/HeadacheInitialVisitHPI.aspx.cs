using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Medical_Headache : System.Web.UI.Page
{
    private static string stringEncounterDate;
    private string HPIData;
    private string SummaryData;
    StringBuilder reportHPI;// = new StringBuilder();
    StringBuilder reportSummary;

    protected void reloadPage(object sender, EventArgs e)
    {
        Response.Redirect("~/kn_Internal/Medical/Templates/Headache/InitialVisitHeadache.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Master.rblListOfPatients.SelectedIndexChanged += reloadPage;
        if (!IsPostBack)  // Do this only the first time it loads.
        {
            if (Profile.PatientID > 0)
            {
                //dropDownListOfPatients.SelectedValue = Profile.PatientID.ToString();
                dropDownListOfEncounters.Enabled = true;
                labelListOfEncounters.Enabled = true;
            }
            else
            {
                dropDownListOfEncounters.Enabled = false;
                labelListOfEncounters.Enabled = false;
            }
            //labelMissingDateWarning.Visible = false;
        }
    }

    protected void dropDownListOfEncounters_SelectedIndexChanged(object sender, EventArgs e)
    {
        editorReportHPI.Text = null;
        editorReportSummary.Text = null;
        
        if (dropDownListOfEncounters.SelectedValue != "0")
        {
            mvHeadache.Visible = true;
            stringEncounterDate = Convert.ToDateTime(dropDownListOfEncounters.SelectedItem.Text).ToShortDateString();
            string todaysDate = DateTime.Today.ToShortDateString();
            if (stringEncounterDate != todaysDate)
            {
                labelDateWarning.Visible = true;
            }
            else
            {
                labelDateWarning.Visible = false;
            }
        }
        else
        {
            mvHeadache.Visible = false;
            labelDateWarning.Visible = false;
        }
    }


    protected void dropDownListOfEncounters_DataBound(object sender, EventArgs e)
    {
        ListItem myListItem0 = new ListItem();
        myListItem0.Text = "Select Date and Time";
        myListItem0.Value = "0";
        dropDownListOfEncounters.Items.Insert(0, myListItem0);
        if (!IsPostBack)  // Do this only the first time it loads.
        {
            if (Request.QueryString["encounterID"] != null)
            {
                try
                {
                    //dropDownListOfEncounters.SelectedItem.Text = Request.QueryString["encounterDate"];
                    dropDownListOfEncounters.SelectedValue = Request.QueryString["encounterID"];
                    if (dropDownListOfEncounters.SelectedIndex > 0)
                    {
                        mvHeadache.Visible = true;
                    }
                }
                catch
                {
                }
            }

        }

    }



    
    private string generateHPIReport()
    {
        DateTime dtEncounterDate = Convert.ToDateTime(stringEncounterDate);
        GetPatientName patient = new GetPatientName(Profile.PatientID, dtEncounterDate);
        //StringBuilder reportHPI = new StringBuilder();
        reportHPI = new StringBuilder();
        string His_Her = "X", He_She = "X", him_her = "X", his_her = "X", he_she = "X";
        string relationship = textBoxRelationship.Text.ToLower().Trim();

        if (patient.PatientGender == "male")
        {
            His_Her = "His";
            He_She = "He";
            him_her = "him";
            his_her = "his";
            he_she = "he";
        }
        else if (patient.PatientGender == "female")
        {
            His_Her = "Her";
            He_She = "She";
            him_her = "her";
            his_her = "her";
            he_she = "she";
        }

        // History Provided By
        reportHPI.Append(patient.PatientFirstName + " is a " + patient.AgeWithUnits + " " + patient.PatientGender + " ");
        reportHPI.Append("who was seen in our office today, accompanied by " + his_her + " ");
        reportHPI.Append(relationship + ", for the intial evaluation of headaches.  ");
        reportHPI.Append(His_Her + " past history is significant for:  " + textBoxPastHistorySignificantFor.Text);
        reportHPI.Append("<br/><br/>");


        // Duration
        reportHPI.Insert(0, "<p>");
        reportHPI.Append("The patient has had headaches for " + this.radioButtonListDuration.SelectedValue.ToString() + " and ");
        
        // Kinds of headaches
        reportHPI.Append("experiences " + radioButtonListKindsOfHeadaches.SelectedValue.ToString() + " of headache.\n\n");
        
        // Location
        reportHPI.Append("Headache location is described as ");
        processCheckBoxList(checkBoxListLocation);
        reportHPI.Append(".  ");
        reportHPI.Append("</p>");

        // Progression
        reportHPI.Append("<p>");
        reportHPI.Append("Over time, the headache has " + radioButtonListProgression.SelectedValue.ToString() + ".  ");
        if (radioButtonListProgression.SelectedIndex == 2)
        {
            reportHPI.Append("Headache has " + radioButtonListGottenWorse.SelectedValue.ToString() + " for last " + textBoxGottenWorseSinceWhen.Text + ".  ");
        }

        // Worsens with
        if (countCheckedItemsInCheckBoxList(checkBoxListHeadaceWorsensWith) > 0)
        {
            reportHPI.Append("Patient reports that headache worsens with ");
            processCheckBoxList(checkBoxListHeadaceWorsensWith);
            reportHPI.Append(".  ");
        }
        else
        {
            reportHPI.Append("Patient reports that headache does NOT worsens with activity, standing, or lying");
            reportHPI.Append(".  ");
        }

        // Severity
        reportHPI.Append("Pain is reported to be " + radioButtonListSeverity.SelectedValue.ToString() + ",  ");
        reportHPI.Append("( " + radioButtonListSeverityScale.SelectedValue.ToString() + "/10 ).  ");

        // Nature
        reportHPI.Append("The headache is described as ");
        processCheckBoxList(checkBoxListNature);
        reportHPI.Append(".  ");

        // Frequency
        reportHPI.Append("Frequency of headaches is " + radioButtonListFrequency.SelectedValue.ToString() + ".  ");
        reportHPI.Append("</p>");

        // Timing
        reportHPI.Append("Headaches usually occur ");
        processCheckBoxList(checkBoxListTiming);
        reportHPI.Append(".  ");

        if (radioButtonListWakeUpFromSleep.SelectedIndex == 0)// Yes wake up
        {
            reportHPI.Append("The headache wakes patient up from sleep.  ");
        }
        else
        {
            reportHPI.Append("The headache does not wake patient up from sleep.  ");
        }

        if (radioButtonListWakeUpFromSleep.SelectedIndex == 0)// Yes Vomiting waking up
        {
            reportHPI.Append(patient.PatientFirstName + " reports vomiting upon awakening.  ");
        }
        else
        {
            reportHPI.Append(patient.PatientFirstName + " does not vomit upon awakening.  ");
        }

        if (radioButtonListWakeUpFromSleep.SelectedIndex == 0)// Yes aura
        {
            reportHPI.Append(He_She + " has an aura associated with the headache.  ");
        }
        else
        {
            reportHPI.Append(He_She + " does not have an aura associated with the headache.  ");
        }
        ///////////////////////

        // Associated Factors
        reportHPI.Append(patient.PatientFirstName + " reports ");
        processCheckBoxList(checkBoxListAssociatedFactors);
        reportHPI.Append(".  ");

        
        // General1
        
        //// Treatment
        reportHPI.Append("When a headache occurs, the patient ");
        processCheckBoxList(checkBoxListTreatment);
        reportHPI.Append(".  ");

        //// Pain Killers
        reportHPI.Append("Pain killers are " + radioButtonListPainKillers.SelectedValue.ToString() + ".  ");

        //// Sleeping
        reportHPI.Append("Sleeping " + radioButtonListSleeping.SelectedValue.ToString() + " the headache.  ");

        //// Ill
        reportHPI.Append("During headaches, the patient " + radioButtonListIll.SelectedValue.ToString() + " ill.  ");

        //// Anorexia
        reportHPI.Append("Headaches " + radioButtonListAppetite.SelectedValue.ToString() + " anorexia.\n\n");

        //// Allergies
        reportHPI.Append("The patient " + radioButtonListAllergies.SelectedValue.ToString() + " a history of allergies.  ");

        //// Skips Meals
        reportHPI.Append("The patient " + radioButtonListMeals.SelectedValue.ToString() + " meals.\n\n");

        ////Vision
        reportHPI.Append("The vision ");
        if (radioButtonVisionYes.Checked)
        {
            reportHPI.Append("has been checked in the last six months.  ");
            if (radioButtonGlassesYes.Checked)
            {
                reportHPI.Append("Corrective lenses were prescribed.  ");
                reportHPI.Append("The patient " + radioButtonListWearsGlasses.SelectedValue.ToString() + " glasses/contact lenses.  ");
            }
            if (radioButtonGlassesNo.Checked)
            {
                reportHPI.Append("Corrective lenses were not prescribed.  ");
            }

        }
        if (radioButtonVisionNo.Checked)
        {
            reportHPI.Append("has not been checked in the last six months.  ");
        }

        //// Snoring
        reportHPI.Append("The patient ");
        if (radioButtonSnoringYes.Checked)
        {
            reportHPI.Append("has a history of snoring.  ");
            reportHPI.Append(radioButtonListBreathing.SelectedValue.ToString());
        }
        if (radioButtonSnoringNo.Checked)
        {
            reportHPI.Append("does not have a history of snoring.  ");
        }
        reportHPI.Append("\n\n");


        // General 2

        //// Food
        if (countCheckedItemsInCheckBoxList(checkBoxListFood) > 0)
        {
            reportHPI.Append("The patient reports consuming ");
            processCheckBoxList(checkBoxListFood);
            reportHPI.Append(".");
        }
        else
        {
            reportHPI.Append("The patient reports NOT consuming foods and drinks such as caffeinated sodas, tea, coffee, chocolate or smoked meats.");
        }

        reportHPI.Append("\n\n");
        
        
        //// Missed School
        switch (radioButtonListMissedSchool.SelectedValue)
        {
            case "0":
                reportHPI.Append(patient.PatientFirstName + " has never missed school due to headaches.  ");
                break;
            case "1":
                reportHPI.Append(patient.PatientFirstName + " has missed a few days of school due to headaches.  ");
                break;
            case "2":
                reportHPI.Append(patient.PatientFirstName + " has missed a few weeks of school due to headaches.  ");
                break;
            case "3":
                reportHPI.Append(patient.PatientFirstName + " is homebound due to headaches.  ");
                break;
        }


        //// Recently taken vitamins, steroids
        if (countCheckedItemsInCheckBoxList(checkBoxListVitaminsSteroids) > 0)
        {
            reportHPI.Append("The patient reports that " + he_she  + " has recently taken ");
            processCheckBoxList(checkBoxListFood);
            reportHPI.Append(".");
        }
        else
        {
            reportHPI.Append("The patient reports that " + he_she + "has NOT recently taken either vitamins or steroids.  ");
        }


        //// Sinus Disease
        if (radioButtonListSinus.SelectedIndex == 0)//Yes
        {
            reportHPI.Append(patient.PatientFirstName + " has a history of sinus infections.  ");
        }
        else
        {
            reportHPI.Append(patient.PatientFirstName + " does not have a history of sinus infections.  ");
        }

        //// Trouble falling asleep
        if (radioButtonListFallingAsleep.SelectedIndex == 0)//Yes
        {
            reportHPI.Append(He_She + " has trouble falling asleep.  ");
        }
        else
        {
            reportHPI.Append(He_She + " does not have trouble falling asleep.  ");
        }

        
        //// Maintaining Sleep
        if (radioButtonListMaintainingSleep.SelectedIndex == 0)//Yes
        {
            reportHPI.Append(He_She + " has trouble staying asleep.  ");
        }
        else
        {
            reportHPI.Append(He_She + " does not have trouble staying asleep.  ");
        }


        //// Illicit Drug Use
        if (radioButtonListDrugAbuse.SelectedIndex == 0)//Yes
        {
            reportHPI.Append(patient.PatientFirstName + " has a history of illicit drug use.  ");
        }
        else
        {
            reportHPI.Append(patient.PatientFirstName + " reports that " + he_she + " does not have a history of illicit drug use.  ");
        }


        //// Body aches and pains
        if (radioButtonListDiffusedBodyAchesPain.SelectedIndex == 0)//Yes
        {
            reportHPI.Append(patient.PatientFirstName + " has a history diffused body aches and pains.  ");
        }
        else
        {
            reportHPI.Append(patient.PatientFirstName + " does not have a history of diffused body aches and pains.  ");
        }


        //// Depression
        if (radioButtonListDepression.SelectedIndex == 0)//Yes
        {
            reportHPI.Append(He_She + " has a history of depression.  ");
        }
        else
        {
            reportHPI.Append(He_She + " does not have a history of depression.  ");
        }


        //// Thyroid problems
        if (radioButtonListThyroidProblems.SelectedIndex == 0)//Yes
        {
            reportHPI.Append(He_She + " has a history of thyroid problems.  ");
        }
        else
        {
            reportHPI.Append(He_She + " does not have a history of thyroid problems.  ");
        }


        //// Patient's weight change
        switch (radioButtonListWeightChange.SelectedValue)
        {
            case "0":
                reportHPI.Append("No change in weight is reported.  ");
                break;
            case "1":
                reportHPI.Append(patient.PatientFirstName + " has recently gained weight.  ");
                break;
            case "2":
                reportHPI.Append(patient.PatientFirstName + " has lost weight due to dieting.  ");
                break;
            case "3":
                reportHPI.Append(patient.PatientFirstName + " has lost weight and the weight loss was not due to dieting.  ");
                break;
        }
        
        
        reportHPI.Append("\n\n");


        // Family History
        //////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\
        //// Migraine
        if (countCheckedItemsInCheckBoxList(checkBoxListFamilyHistoryMigraine) > 0)
        {
            reportHPI.Append("History of migranes is reported in ");
            processCheckBoxList(checkBoxListFamilyHistoryMigraine);
            reportHPI.Append(".");
        }
        else
        {
            reportHPI.Append("There is no family history of migraines.  ");
        }

        //// Aneurysm
        if (radioButtonListFamilyHistoryAneurysm.SelectedIndex == 0)//Yes
        {
            reportHPI.Append("There is family history of aneurysms.  ");
        }
        else
        {
            reportHPI.Append("There is no family history of aneurysms.  ");
        }


        //// Seizures
        if (radioButtonListFamilyHistorySeizures.SelectedIndex == 0)//Yes
        {
            reportHPI.Append("There is family history of seizures.  ");
        }
        else
        {
            reportHPI.Append("There is no family history of seizures.  ");
        }


        //// Thyroid
        if (radioButtonListFamilyHistoryThyroidProblems.SelectedIndex == 0)//Yes
        {
            reportHPI.Append("There is family history of thyroid problems.  ");
        }
        else
        {
            reportHPI.Append("There is no family history of thyroid problems.  ");
        }
        
        
        reportHPI.Append("\n\n");


        // Preventive Medication
        if (checkBoxNoPreventiveMedications.Checked)
        {
            reportHPI.Append("The patient reports NOT having taken any preventive headache medications.");
        }
        else
        {
            if (checkBoxPropranolol.Checked)
            {
                reportHPI.Append("The patient reports taking Propranolol, which ");
                reportHPI.Append(radioButtonListPropranololEffective.SelectedValue);
                reportHPI.Append(" effective at preventing headaches.  ");
            }
            if (checkBoxPeriactin.Checked)
            {
                reportHPI.Append("Periactin was taken, which the patient reports ");
                reportHPI.Append(radioButtonListPeriactin.SelectedValue);
                reportHPI.Append(" effective at preventing headaches.  ");
            }
            if (checkBoxElavil.Checked)
            {
                reportHPI.Append("The patient has taken Elavil, which ");
                reportHPI.Append(radioButtonListElavil.SelectedValue);
                reportHPI.Append(" effective at preventing headaches.  ");
            }
            if (checkBoxTopamax.Checked)
            {
                reportHPI.Append("The patient reports taking Topamax and it ");
                reportHPI.Append(radioButtonListTopamax.SelectedValue);
                reportHPI.Append(" been effective at preventing headaches.  ");
            }
            if (checkBoxDepakote.Checked)
            {
                reportHPI.Append("Depakote has been taken and the patient reports that it ");
                reportHPI.Append(radioButtonListDepakote.SelectedValue);
                reportHPI.Append(" effective at preventing headaches.  ");
            }
            if (checkBoxOtherPreventiveMedication.Checked)
            {
                reportHPI.Append("Other preventive medications taken include: ");
                reportHPI.Append(textBoxOtherPreventiveMedication.Text + ".");
            }
        }
        reportHPI.Append("\n\n");


        // Other Pain Medications
        if (checkBoxNoMedications.Checked)
        {
            reportHPI.Append("The patient reports NOT having taken any pain medications for headache.");
        }
        else
        {
            if (checkBoxTylenol.Checked)
            {
                reportHPI.Append("The patient reports taking Tylenol, which ");
                reportHPI.Append(radioButtonListTylenolEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxMotrinIbuprofen.Checked)
            {
                reportHPI.Append("The patient reports taking Motrin/Ibuprofen, which ");
                reportHPI.Append(radioButtonListMotrinIbuprofenEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxAleveNaproxen.Checked)
            {
                reportHPI.Append("The patient reports taking Aleve/Naproxen, which ");
                reportHPI.Append(radioButtonListAleveNaproxenEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxMidrin.Checked)
            {
                reportHPI.Append("The patient reports taking Midrin, which ");
                reportHPI.Append(radioButtonListMidrinEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxFioricet.Checked)
            {
                reportHPI.Append("The patient reports taking Fioricet, which ");
                reportHPI.Append(radioButtonListFioricetEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxZomig.Checked)
            {
                reportHPI.Append("The patient reports taking Zomig, which ");
                reportHPI.Append(radioButtonListZomigEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxImitrex.Checked)
            {
                reportHPI.Append("The patient reports taking Imitrex, which ");
                reportHPI.Append(radioButtonListImitrexEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxTylenolIII.Checked)
            {
                reportHPI.Append("The patient reports taking Tylenol III, which ");
                reportHPI.Append(radioButtonListTylenolIIIEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxRelpax.Checked)
            {
                reportHPI.Append("The patient reports taking Relpax, which ");
                reportHPI.Append(radioButtonListRelpaxEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxBCPowder.Checked)
            {
                reportHPI.Append("The patient reports taking B C Powder, which ");
                reportHPI.Append(radioButtonListBCPowderEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxErgocaff.Checked)
            {
                reportHPI.Append("The patient reports taking Ergocaff, which ");
                reportHPI.Append(radioButtonListErgocaffEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxMigranal.Checked)
            {
                reportHPI.Append("The patient reports taking Migranal, which ");
                reportHPI.Append(radioButtonListMigranalEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxExcedrinMigraine.Checked)
            {
                reportHPI.Append("The patient reports taking Excedrin Migraine, which ");
                reportHPI.Append(radioButtonListExcedrinMigraineEffective.SelectedValue);
                reportHPI.Append(" effective in treating the headache.  ");
            }
            if (checkBoxOtherMedications.Checked)
            {
                reportHPI.Append("Other pain medications taken include: ");
                reportHPI.Append(textBoxOtherMedications.Text + ".");
            }
        }
        reportHPI.Append("\n\n");

        return reportHPI.ToString();
        //  Insert Summary into cute editor
        //editorReportHPI.Text = reportHPI.ToString();


    }


    private string generateSummaryReport()
    {
        DateTime dtEncounterDate = Convert.ToDateTime(stringEncounterDate);
        GetPatientName patient = new GetPatientName(Profile.PatientID, dtEncounterDate);
        //StringBuilder reportHPI = new StringBuilder();
        reportSummary = new StringBuilder();
        string His_Her = "X", He_She = "X", him_her = "X", his_her = "X", he_she = "X";
        string relationship = textBoxRelationship.Text.ToLower().Trim();

        if (patient.PatientGender == "male")
        {
            His_Her = "His";
            He_She = "He";
            him_her = "him";
            his_her = "his";
            he_she = "he";
        }
        else if (patient.PatientGender == "female")
        {
            His_Her = "Her";
            He_She = "She";
            him_her = "her";
            his_her = "her";
            he_she = "she";
        }

        // History Provided By
        reportSummary.Append(patient.PatientFirstName + " is a " + patient.AgeWithUnits + " " + patient.PatientGender + " ");
        reportSummary.Append("who was seen in our office today, accompanied by " + his_her + " ");
        reportSummary.Append(relationship + ", for the intial evaluation of headaches.  ");
        reportSummary.Append(His_Her + " past history is significant for:  " + textBoxPastHistorySignificantFor.Text);
        reportSummary.Append("<br/><br/>");


        // History is suggestive of
        if (countCheckedItemsInCheckBoxList(checkBoxListPatientHistorySuggestiveOf) > 0)
        {
            reportSummary.Append("Patient history is suggestive of ");
            processCheckBoxListSummary(checkBoxListPatientHistorySuggestiveOf);
            reportSummary.Append(".  ");
        }
        else
        {
            reportSummary.Append("The patient history is suggestive of ____________________ .  ");
        }


        // Neurological Exam
        reportSummary.Append(textBoxNeurologicalExamShowed.Text);
        

        // Recommend
        if (countCheckedItemsInCheckBoxList(checkBoxListRecommend) > 0)
        {
            reportSummary.Append("I recommend ");
            processCheckBoxListSummary(checkBoxListRecommend);
            reportSummary.Append(".  ");
        }
        else
        {
            reportSummary.Append("I do not recommend any changes in diet or other non-pharmalogical intervention at this time.  ");
        }


        // ProphylaxisTreatment
        if (countCheckedItemsInCheckBoxList(checkBoxListProphylaxisTreatment) > 0)
        {
            reportSummary.Append("Prophylaxis treatment will be ");
            processCheckBoxListSummary(checkBoxListProphylaxisTreatment);
            reportSummary.Append(".  ");
        }
        else
        {
            reportSummary.Append("I do not recommend any prophylaxis treatment at this time.  ");
        }

        // Abortive Treatment
        if (countCheckedItemsInCheckBoxList(checkBoxListAbortiveTreatment) > 0)
        {
            reportSummary.Append("Abortive treatment will be ");
            processCheckBoxListSummary(checkBoxListAbortiveTreatment);
            reportSummary.Append(".  ");
        }
        else
        {
            reportSummary.Append("I do not recommend any abortive treatment at this time.  ");
        }


        return reportSummary.ToString();
    }

    
    private int countCheckedItemsInCheckBoxList(CheckBoxList aCheckBoxList)
    {
        int totalSelectedItems = 0;

        foreach (ListItem li in aCheckBoxList.Items)
        {
            if (li.Selected)
            {
                totalSelectedItems++;
            }
        }
        return totalSelectedItems;
    }


    private void processCheckBoxList(CheckBoxList aCheckBoxList)
    {
        int totalSelectedItems = 0;
        int currentlySelectedItems = 0;

        foreach (ListItem li in aCheckBoxList.Items)
        {
            if (li.Selected)
            {
                totalSelectedItems++;
            }
        }


        foreach (ListItem li in aCheckBoxList.Items)
        {
            if (li.Selected)
            {
                currentlySelectedItems++;
                reportHPI.Append(li.Value);
                if ((currentlySelectedItems == 1) & (totalSelectedItems == 2))
                {
                    reportHPI.Append(" and ");
                }
                if ((currentlySelectedItems == (totalSelectedItems - 1)) & (totalSelectedItems >= 3))
                {
                    reportHPI.Append(", and ");
                }
                if ((currentlySelectedItems < (totalSelectedItems - 1)) & (totalSelectedItems >= 3))
                {
                    reportHPI.Append(", ");
                }
            }
        }

    }
    
    private void processCheckBoxListSummary(CheckBoxList aCheckBoxList)
    {
        int totalSelectedItems = 0;
        int currentlySelectedItems = 0;

        foreach (ListItem li in aCheckBoxList.Items)
        {
            if (li.Selected)
            {
                totalSelectedItems++;
            }
        }


        foreach (ListItem li in aCheckBoxList.Items)
        {
            if (li.Selected)
            {
                currentlySelectedItems++;
                reportSummary.Append(li.Value);
                if ((currentlySelectedItems == 1) & (totalSelectedItems == 2))
                {
                    reportSummary.Append(" and ");
                }
                if ((currentlySelectedItems == (totalSelectedItems - 1)) & (totalSelectedItems >= 3))
                {
                    reportSummary.Append(", and ");
                }
                if ((currentlySelectedItems < (totalSelectedItems - 1)) & (totalSelectedItems >= 3))
                {
                    reportSummary.Append(", ");
                }
            }
        }

    }



    protected void radioButtonListProgression_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (radioButtonListProgression.SelectedIndex == 2)
        {
            radioButtonListGottenWorse.Visible = true;
            textBoxGottenWorseSinceWhen.Visible = true;
        }
        else
        {
            radioButtonListGottenWorse.Visible = false;
            radioButtonListGottenWorse.ClearSelection();
            textBoxGottenWorseSinceWhen.Visible = false;
            textBoxGottenWorseSinceWhen.Text = null;
        }
    }

    //protected void radioButtonListRelationships_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    textBoxRelationship.Text = radioButtonListRelationships.SelectedValue;
    //}


    protected void buttonProcessRelationship_Click(object sender, EventArgs e)
    {

        StringBuilder tempString = new StringBuilder();
        int totalSelectedItems = 0;
        int currentlySelectedItems = 0;

        foreach (ListItem li in checkBoxListRelationships.Items)
        {
            if (li.Selected)
            {
                totalSelectedItems++;
            }
        }


        foreach (ListItem li in checkBoxListRelationships.Items)
        {
            if (li.Selected)
            {
                currentlySelectedItems++;
                tempString.Append(li.Value);
                if ((currentlySelectedItems == 1) & (totalSelectedItems == 2))
                {
                    tempString.Append(" and ");
                }
                if ((currentlySelectedItems == (totalSelectedItems - 1)) & (totalSelectedItems >= 3))
                {
                    tempString.Append(", and ");
                }
                if ((currentlySelectedItems < (totalSelectedItems - 1)) & (totalSelectedItems >= 3))
                {
                    tempString.Append(", ");
                }
            }
        }

        textBoxRelationship.Text = tempString.ToString();
    }
 
    
    protected void getCurrentVisitHPIData()
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        try
        {
            SqlCommand myCommand = new SqlCommand("SELECT HPIText FROM kn_Medical_Patient_Encounter_HPI WHERE (EncounterID = @EncounterID)");
            myCommand.Connection = myConnection;
            myCommand.Parameters.AddWithValue("@EncounterID", dropDownListOfEncounters.SelectedValue);
            myConnection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();

            while (myReader.Read())
            {
                HPIData = Convert.ToString(myReader["HPIText"]);
            }
            myReader.Close();
        }

        finally
        {
            myConnection.Close();
        }

    }

    protected void getCurrentVisitSummaryData()
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        try
        {
            SqlCommand myCommand = new SqlCommand("SELECT SummaryText FROM kn_Medical_Patient_Encounter_Summary WHERE (EncounterID = @EncounterID)");
            myCommand.Connection = myConnection;
            myCommand.Parameters.AddWithValue("@EncounterID", dropDownListOfEncounters.SelectedValue);
            myConnection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();

            while (myReader.Read())
            {
                SummaryData = Convert.ToString(myReader["SummaryText"]);
            }
            myReader.Close();
        }

        finally
        {
            myConnection.Close();
        }
    }

    protected void saveCurrentVisitHPIData()
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        try
        {
            SqlCommand myCommand = new SqlCommand("DELETE FROM kn_Medical_Patient_Encounter_HPI WHERE (EncounterID = @EncounterID)");
            myCommand.Connection = myConnection;
            myCommand.Parameters.AddWithValue("@EncounterID", dropDownListOfEncounters.SelectedValue);
            myConnection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();
            myReader.Close();
        }

        finally
        {
            myConnection.Close();
        }

        try
        {
            SqlCommand myCommand = new SqlCommand("INSERT INTO kn_Medical_Patient_Encounter_HPI (EncounterID, HPIText) VALUES (@EncounterID,@HPIText)");
            myCommand.Connection = myConnection;
            myCommand.Parameters.AddWithValue("@EncounterID", dropDownListOfEncounters.SelectedValue);
            myCommand.Parameters.AddWithValue("@HPIText", HPIData);
            myConnection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();

            myReader.Close();
        }

        finally
        {
            myConnection.Close();
        }

    }

    protected void saveCurrentVisitSummaryData()
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        try
        {
            SqlCommand myCommand = new SqlCommand("DELETE FROM kn_Medical_Patient_Encounter_Summary WHERE (EncounterID = @EncounterID)");
            myCommand.Connection = myConnection;
            myCommand.Parameters.AddWithValue("@EncounterID", dropDownListOfEncounters.SelectedValue);
            myConnection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();
            myReader.Close();
        }

        finally
        {
            myConnection.Close();
        }

        try
        {
            SqlCommand myCommand = new SqlCommand("INSERT INTO kn_Medical_Patient_Encounter_Summary (EncounterID, SummaryText) VALUES (@EncounterID,@SummaryText)");
            myCommand.Connection = myConnection;
            myCommand.Parameters.AddWithValue("@EncounterID", dropDownListOfEncounters.SelectedValue);
            myCommand.Parameters.AddWithValue("@SummaryText", SummaryData);
            myConnection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();

            myReader.Close();
        }

        finally
        {
            myConnection.Close();
        }

    }


    protected void buttonCreateReport_Click(object sender, EventArgs e)
    {
        editorReportHPI.Text = generateHPIReport();
        editorReportSummary.Text = generateSummaryReport();
    }

    protected void buttonSaveReport_Click(object sender, EventArgs e)
    {
        getCurrentVisitHPIData();
        getCurrentVisitSummaryData();
        HPIData += "<BR /><BR />" + editorReportHPI.Text;
        SummaryData += "<BR /><BR />" + editorReportSummary.Text;
        saveCurrentVisitHPIData();
        saveCurrentVisitSummaryData();
    }

   
}
