This is to easily add cookies banner connected to Google Tag Manager
```html
<!DOCTYPE html>
<html>

<head>

      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <script>

      // get user GTM ID
      const userGTMID = String("{{ pass_gtm_id() }}");

      // Define dataLayer and the gtag function: this must be done BEFORE GTM declaration
      window.dataLayer = window.dataLayer || [];
      function gtag() { dataLayer.push(arguments); }

      // these are the default values for cookies consent
      const gtagDefaultValues = {
        'ad_user_data': 'denied',
        'ad_personalization': 'denied',
        'ad_storage': 'denied',
        'analytics_storage': 'denied',
        'personalization_storage': 'denied',
        'functionality_storage': 'denied',
        'security_storage': 'denied',
        'wait_for_update': 500,
      };

      // set default cookie values
      if( localStorage.getItem('consentMode') === null ){
        // Set default consent to 'denied' as a placeholder
        gtag('consent', 'default', gtagDefaultValues );
      } else {
        // if user already set their cookie consent get it from localStorage
        gtag( 'consent', 'default', JSON.parse(localStorage.getItem('consentMode')) );
      }
      </script>

      <!-- Google Tag Manager -->
      <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
      new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
      j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
      'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer', 'None');</script>
      <!-- End Google Tag Manager -->

      <!-- upload cookies CSS styles -->
      <link rel="stylesheet" href="{{ url_for('cookies.static', filename='cookies.css') }}">

      <!-- bootstrap -->
      <script
        src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous">
      </script>
      <!-- bootstrap -->
      <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
      </script>
      <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous">

        <style>
        #cookie-consent-container {
          text-align: right;
          position: fixed;
          bottom: 25%;
          opacity: 0.95;
          z-index: 10;
          width: 80%;
          height: 300px;
          left: auto;
          right: 10%;
          margin-right: 10px;
          margin-left: 10px;
        }

        .cookie-text-container {
          text-align: left;
        }

        .cookie-consent-subcontainer {
          text-align: center;
          margin-left: auto;
          margin-right: 0;
          width: 100%;
          border: 0px solid #4d4dff;
        }

        .cookie-consent-text {
          text-align: left;
        }

        .cookie-text-container {
          height: 55%;
          margin-bottom: 2%;
          overflow-y: scroll;
        }

        #cookie-details-table {
          width: 100%;
          border: 0px solid #4d4dff;
          text-align: left;
          border-collapse: collapse;
        }

        .cookie-details-table-cell-div-container {
          border: 0px solid #4d4dff;
        }

        .cookie-details-table-cell-div-lower {
          font-size: 70%;
        }

        .cookie-details-table-row {
          border-bottom: 1px solid #4d4dff;
        }

        .cookie-details-table-cell-title {
          font-weight: bold;
          font-size: 90%;
        }

        .cookie-details-table-cell-switcher {
          font-weight: bold;
        }


        .sliding-switch {
         position: relative; left: 0px; top: 0px;
         appearance: none;
         width: 48px;
         height: 12px;
         border-radius: 12px;
         background-color: #dddddd;
        }

        .sliding-switch::before {
         content: "";
         position: absolute; left: -4px; top: -2px;
         height: 16px;
         width: 16px;
         border-radius: 100%;
         background-color: #888888;
        }

        .sliding-switch:checked {
         background-color: #91E491;
        }

        .sliding-switch:checked::before {
         left: calc(100% - 12px);
         background-color: #0FCE0F;
        }


        .floating-widget {
          position: fixed;
          bottom: 50px;
          left: 50px;
          width: 50px;
          height: 50px;
          background-color: #fff;
          border-radius: 50%;
          box-shadow: 0 5px 5px rgba(0,0,0,0.1);
        }

        .floating-widget button {
          position: relative;
          width: 100%;
          height: 100%;
          display: flex;
          align-items: center;
          justify-content: center;
          border: none;
          padding: 0;
          border-radius: 50%;
          font-size: 40px;
          color: #a13dea;
          transition: 0.3s ease-in-out;
          outline: none;
          cursor: pointer;
        }

        .floating-widget.active button {
          transform: rotate(135deg);
        }

        .floating-widget ul {
          position: absolute;
          bottom: 55px;
          background-color: #fff;
          min-width: 100px;
          display: grid;
          grid-gap: 10px;
          border-radius: 20px;
          padding: 20px;
          list-style-type: none;
          margin: 0;
          text-align: center;
          opacity: 0;
          visibility: hidden;
          transition: 0.3s;
        }

        .floating-widget.active ul {
          opacity: 1;
          visibility: visible;
          transition: 0.3s;
          bottom: 65px;
        }

        .cookie-consent-header {
          text-align: center;
        }

        #cookie-label-table {
          width: 90%;
          border-collapse: collapse;
          table-layout: fixed;
        }

        #cookie-label-row {
          border: 0px solid blue;
        }

        .cookie-label-cell {
          padding: 0;
          margin: 0;
          text-align: center;
          font-weight: bold;
        }

        .cookie-label-cell-div {
          border-bottom: 2px solid #4d4dff;
          width: 80%;
        }

        #cookie-consent-label, #cookie-details-label, #cookie-about-label {
          font-size: 150%;
          font-weight: bold;
          text-decoration: none;
          color: #4d4dff;
        }

        stream.italic-text {
          font-style: italic;
        }

        stream.underlined-text {
          text-decoration: underline;
        }
        </style>
</head>




<body>
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe id="gtm-no-script" src="https://www.googletagmanager.com/ns.html?id="
    height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->

      <div class="alert alert-light alert-dismissible fade show" role="alert" id="cookie-consent-container">
        <div class="cookie-consent-subcontainer">
          <div class="cookie-consent-header">
            <table id="cookie-label-table">
              <tr id="cookie-label-row">
                <td class="cookie-label-cell">
                  <div class="cookie-label-cell-div" id="cookie-label-cell-div-consent">
                    <button id="cookie-consent-label" class="btn btn-link">Cookies</button>
                  </div>
                </td>
                <td class="cookie-label-cell">
                  <div class="cookie-label-cell-div" id="cookie-label-cell-div-details">
                    <button id="cookie-details-label" class="btn btn-link">Details</button>
                  </div>
                </td>
                <td class="cookie-label-cell">
                  <div class="cookie-label-cell-div" id="cookie-label-cell-div-about">
                    <button id="cookie-about-label" class="btn btn-link">More</button>
                  </div>
                </td>
              </tr>
            </table>
          </div>
        </div>
        <div class="cookie-text-container">
          <div id="cookie-consent-text">
            <stream style="font-weight: bold;">This website uses cookies</stream>
            <br>
            <stream style="font-size: 80%;">
              Cookies are used to personalise content,
              to analyze traffic, and to provide specific features.
              We also share information about your use of our site
              with analytics and advertising partners
              who may combine it with other information
              that you have provided to them
              or that were collected from your use of their services.
              <br>
              Please have a look at Details section and
              <a href="https://support.google.com/analytics/answer/12334711?hl=en" target="_blank">google analytics consent types</a>
              for the list of consents we use.
              <br>
              You will always be able to change your selection using this little shield icon
              on the bottom left of this page.
            </stream>
          </div>
          <div id="cookie-details-text">
            <table id="cookie-details-table">
              <colgroup>
                 <col span="1" style="width: 85%;">
                 <col span="1" style="width: 15%;">
              </colgroup>
              <tbody>
                <tr class="cookie-details-table-row">
                  <td class="cookie-details-table-cell">
                    <div class="cookie-details-table-cell-div-container" id="cookie-details-table-cell-necessary-div-container">
                      <div class="cookie-details-table-cell-div-upper" id="cookie-details-table-cell-necessary-div-upper">
                        <stream class="cookie-details-table-cell-title">Necessary</stream>
                      </div>
                      <div class="cookie-details-table-cell-div-lower" id="cookie-details-table-cell-necessary-div-lower">
                        Necessary cookies are a core need to make a website
                        actually usable by enabling basic functions
                        like page navigation or access to secure areas.
                        Precisely, in this website these are:
                        <stream class="italic-text">functionality_storage</stream> and
                        <stream class="italic-text">security_storage</stream> from
                        <a href="https://support.google.com/analytics/answer/12334711?hl=en" target="_blank">google analytics</a>
                      </div>
                    </div>
                  </td>
                  <td class="cookie-details-table-cell-switcher">
                    <input id="cookie-consent-necessary" class="sliding-switch" style="background-color: #dddddd;" type="checkbox" value="Necessary" checked disabled>
                  </td>
                </tr>
                <tr class="cookie-details-table-row">
                  <td class="cookie-details-table-cell">
                    <div class="cookie-details-table-cell-div-container" id="cookie-details-table-cell-analytics-div-container">
                      <div class="cookie-details-table-cell-div-upper" id="cookie-details-table-cell-analytics-div-upper">
                        <stream class="cookie-details-table-cell-title">Analytics</stream>
                      </div>
                      <div class="cookie-details-table-cell-div-lower" id="cookie-details-table-cell-analytics-div-lower">
                        Analytics cookies are basically intended to understand how visitors interact
                        with this website by collecting and reporting information about a user behavior.
                        <br>
                        Precisely, in this website this is <stream class="italic-text">analytics_storage</stream>
                        cookies from
                        <a href="https://support.google.com/analytics/answer/12334711?hl=en" target="_blank">google analytics</a>
                      </div>
                    </div>
                  </td>
                  <td class="cookie-details-table-cell-switcher">
                    <input id="cookie-consent-analytics" class="sliding-switch" type="checkbox" value="Analytics" checked>
                  </td>
                </tr>
                <tr class="cookie-details-table-row">
                  <td class="cookie-details-table-cell">
                    <div class="cookie-details-table-cell-div-container" id="cookie-details-table-cell-preferences-div-container">
                      <div class="cookie-details-table-cell-div-upper" id="cookie-details-table-cell-preferences-div-upper">
                        <stream class="cookie-details-table-cell-title">Preferences</stream>
                      </div>
                      <div class="cookie-details-table-cell-div-lower" id="cookie-details-table-cell-preferences-div-lower">
                        Preference cookies enable a website to remember different
                        information about a specific user preference
                        that changes the way the website behaves or looks,
                        to better adapt their experience.
                        <br>
                        As example, preference cookies can record your preferred language, your default page, etc.
                        Precisely, in this website this is represented only by
                        <stream class="italic-text">personalization_storage</stream> from
                        <a href="https://support.google.com/analytics/answer/12334711?hl=en" target="_blank">google analytics</a>
                      </div>
                    </div>
                  </td>
                  <td class="cookie-details-table-cell-switcher">
                    <input id="cookie-consent-preferences" class="sliding-switch" type="checkbox" value="Preferences" checked>
                  </td>
                </tr>
                <tr class="cookie-details-table-row">
                  <td class="cookie-details-table-cell">
                    <div class="cookie-details-table-cell-div-container" id="cookie-details-table-cell-marketing-div-container">
                      <div class="cookie-details-table-cell-div-upper" id="cookie-details-table-cell-marketing-div-upper">
                        <stream class="cookie-details-table-cell-title">Marketing</stream>
                      </div>
                      <div class="cookie-details-table-cell-div-lower" id="cookie-details-table-cell-marketing-div-lower">
                        Marketing cookies are intended for marketing uses and track visitors across websites.
                        This allows marketing services to display ads that are aimed at the individual user,
                        based on their internet usage.
                        <br>
                        Precisely, in this website these are <stream class="italic-text">ad_storage</stream>,
                        <stream class="italic-text">ad_user_data</stream> and
                        <stream class="italic-text">ad_personalization</stream>
                        from
                        <a href="https://support.google.com/analytics/answer/12334711?hl=en" target="_blank">google analytics</a>
                      </div>
                    </div>
                  </td>
                  <td class="cookie-details-table-cell-switcher">
                    <input id="cookie-consent-marketing" class="sliding-switch" type="checkbox" value="Marketing">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div id="cookie-about-text">
            <stream style="font-size: 80%;">
              Cookies are small text files used by websites to enrich users' experience.
              Acoording to the law, the only type of cookies that can be stored
              are those strictly necessary for the website functioning.
              For all other types of cookies <stream class="underlined-text">we need your permission</stream>.
              Thus, some cookie are categorized as necessary and processed based on GDPR (art. 6).
              All other cookies, such as preferences, analytics and marketing, require your consent and
              are also processed based on GDPR (art. 6).
              In this website, some cookies are placed by third party services
              (<a href="https://support.google.com/analytics/answer/12159447?hl=en" target="_blank">Google Anlytics</a>).
              You can always - at any time - change/withdraw your consent
              using the little Cookie shield button placed at bottom left of all pages.
              Happy to answer to any further question regarding your consent :)
            </stream>
            <br>
          </div>
        </div>
        <div class="cookie-consent-options" style="text-align: right; white-space:nowrap;">
          <button id="cookie-accept-all-btn" class="btn btn-success">Accept All</button>
          <div id="cookie-customize-btn-div" style="display:inline-block;">
            <button id="cookie-customize-btn" class="btn btn-warning">Customize</button>
          </div>
          <div id="cookie-accept-selected-btn-div" style="display:inline-block;">
            <button id="cookie-accept-selected-btn" class="btn btn-warning">Accept Selected</button>
          </div>
          <button id="cookie-reject-all-btn" class="btn btn-danger">Deny</button>
        <button type="button" id="close-cookie-container-btn" class="btn-close"></button>
      </div>
    </div>

      <div class="floating-widget">
        <button id="show-cookie-banner"><img src="https://i.ibb.co/djKKMpr/cookies-logo.png" class="img-fluid"></img></button>
      </div>
      <script>

      // default display is cookies consent page
      window.onload = displayConsentLabel;

      // this is to change Customize / Accept Selected button based on use
      function showSelectedButton() {
        document.getElementById('cookie-accept-selected-btn-div').style.display = 'inline-block';
        document.getElementById('cookie-customize-btn-div').style.display = 'none';
      };
      function showCustomizeButton() {
        document.getElementById('cookie-accept-selected-btn-div').style.display = 'none';
        document.getElementById('cookie-customize-btn-div').style.display = 'inline-block';
      };

      // this is to change text displayed in cookie banner
      function changeBackgroundColor( element_id, new_color, new_opacity = 1) {
        document.getElementById( element_id ).style.background = new_color;
        document.getElementById( element_id ).style.opacity = new_opacity;
      }
      function displayConsentLabel() {
        document.getElementById('cookie-consent-text').style.display = 'block';
        document.getElementById('cookie-details-text').style.display = 'none';
        document.getElementById('cookie-about-text').style.display = 'none';
        changeBackgroundColor( 'cookie-label-cell-div-consent', 'none', 1 );
        changeBackgroundColor( 'cookie-label-cell-div-details', 'none', 0.4 );
        changeBackgroundColor( 'cookie-label-cell-div-about', 'none', 0.4 );
        showCustomizeButton();
      };
      document.getElementById('cookie-consent-label').addEventListener( 'click', displayConsentLabel );

      function displayDetailsLabel() {
        document.getElementById('cookie-consent-text').style.display = 'none';
        document.getElementById('cookie-details-text').style.display = 'block';
        document.getElementById('cookie-about-text').style.display = 'none';
        changeBackgroundColor( 'cookie-label-cell-div-consent', 'none', 0.4 );
        changeBackgroundColor( 'cookie-label-cell-div-details', 'none', 1 );
        changeBackgroundColor( 'cookie-label-cell-div-about', 'none', 0.4 );
        showSelectedButton();
        // check or not buttons based on their current value in cookies
        var necessarySwitcher = document.getElementById('cookie-consent-necessary');
        var analyticsSwitcher = document.getElementById('cookie-consent-analytics');
        var preferencesSwitcher = document.getElementById('cookie-consent-preferences');
        var marketingSwitcher = document.getElementById('cookie-consent-marketing');
        if (checkConsentModeExists()){
          // check necessary cookies
          if (necessarySwitcher) {
            if (checkSingleConsent('functionality_storage') && checkSingleConsent('security_storage')){
              necessarySwitcher.checked = true;
              necessarySwitcher.disabled = true;
            }else{
              necessarySwitcher.checked = false;
              necessarySwitcher.disabled = false;
            }
          }
          // check analytics cookies
          if (analyticsSwitcher) {
            if (checkSingleConsent('analytics_storage')){
              analyticsSwitcher.checked = true;
            }else{
              analyticsSwitcher.checked = false;
            }
          }
          // check preferences cookies
          if (preferencesSwitcher) {
            if (checkSingleConsent('personalization_storage')){
              preferencesSwitcher.checked = true;
            }else{
              preferencesSwitcher.checked = false;
            }
          }
          // check marketing cookies
          if (marketingSwitcher) {
            if (checkSingleConsent('ad_storage') && checkSingleConsent('ad_user_data') && checkSingleConsent('ad_personalization')){
              marketingSwitcher.checked = true;
            }else{
              marketingSwitcher.checked = false;
            }
          }
        }
      };
      document.getElementById('cookie-details-label').addEventListener( 'click', displayDetailsLabel );
      document.getElementById('cookie-customize-btn').addEventListener( 'click', displayDetailsLabel );

      function displayAboutLabel() {
        document.getElementById('cookie-consent-text').style.display = 'none';
        document.getElementById('cookie-details-text').style.display = 'none';
        document.getElementById('cookie-about-text').style.display = 'block';
        changeBackgroundColor( 'cookie-label-cell-div-consent', 'none', 0.4 );
        changeBackgroundColor( 'cookie-label-cell-div-details', 'none', 0.4 );
        changeBackgroundColor( 'cookie-label-cell-div-about', 'none', 1 );
        showCustomizeButton();
      };
      document.getElementById('cookie-about-label').addEventListener( 'click', displayAboutLabel );


      // this is to check if consentMode is set inside localStorage
      function checkConsentModeExists() {
        if( localStorage.getItem('consentMode') === null ) {
          return false;
        }else{
          return true;
        }
      };


      // this is to check if a single element consent is granted in consentMode
      function checkSingleConsent( consent_name ) {
        if( checkConsentModeExists() ) {
          const jsonConsentModeObject = JSON.parse(localStorage.getItem('consentMode'));
          if ( consent_name in jsonConsentModeObject ) {
            if ( jsonConsentModeObject[consent_name] == 'granted' ) {
              return true;
            };
          };
        };
        return false;
      };

      // floating widget open and show options
      const floatingWidget = document.querySelector('.floating-widget');

      // function to hide cookie preferences container
      var cookieBannerElement = document.getElementById('cookie-consent-container');
      if (cookieBannerElement){
        function hideCookieBanner() {
          cookieBannerElement.style.display = 'none';
          if ( floatingWidget.classList.contains('active') ){
            floatingWidget.classList.remove('active');
          };
        };
      }
      // close cookie banner with button (and restore floatingWidget position if activated)
      document.getElementById('close-cookie-container-btn').addEventListener( 'click', function(){
        hideCookieBanner();
      });

      // function to show cookie banner container
      function showCookieBanner() {
        cookieBannerElement.style.display = 'block';
        if ( !floatingWidget.classList.contains('active') ){
          floatingWidget.classList.add('active');
        };
      };


      // clear localStorage from consentMode object
      function deleteConsentMode() {
        if( localStorage.getItem('consentMode') === null ) {
          //alert( 'no consentMode to delete' );
        } else {
          localStorage.removeItem('consentMode');
        };
      };
      var cookieDebugClearBtn = document.getElementById('cookie-debug-clear-btn');
      if (cookieDebugClearBtn) {
        cookieDebugClearBtn.addEventListener( 'click', deleteConsentMode );
      };

      // set value for the different button options
      function sentConsentAcceptAll(){
        setConsent({
          necessary: true,
          analytics: true,
          preferences: true,
          marketing: true
        });
      };
      function sentConsentAcceptSelected(){
        setConsent({
          necessary: true,
          analytics: document.getElementById('cookie-consent-analytics').checked,
          preferences: document.getElementById('cookie-consent-preferences').checked,
          marketing: document.getElementById('cookie-consent-marketing').checked
        });
      };
      function sentConsentRejectAll(){
        setConsent({
          necessary: false,
          analytics: false,
          preferences: false,
          marketing: false
        });
      };

      // this is to change selection based on user choices
      var cookieAcceptAllBtn = document.getElementById('cookie-accept-all-btn');
      var cookieAcceptSelectedBtn = document.getElementById('cookie-accept-selected-btn');
      var cookieRejectAllBtn = document.getElementById('cookie-reject-all-btn');
      if( localStorage.getItem('consentMode') === null ) {
        if (cookieAcceptAllBtn){
          cookieAcceptAllBtn.addEventListener( 'click', function() {
            // alertConsentMode();
            sentConsentAcceptAll();
            hideCookieBanner();
          });
        };
        if (cookieAcceptSelectedBtn){
          cookieAcceptSelectedBtn.addEventListener( 'click', function() {
            //alertConsentMode();
            sentConsentAcceptSelected();
            hideCookieBanner();
          });
        };
        if (cookieRejectAllBtn){
          cookieRejectAllBtn.addEventListener( 'click', function() {
            //alertConsentMode();
            sentConsentRejectAll();
            hideCookieBanner();
          });
        };
        showCookieBanner();
      // if localStorage has consentMode do not show cookie banner
      }else{
        hideCookieBanner();
        // but if other functions trigger it out, allow change cookie selection
        if (cookieAcceptAllBtn){
          cookieAcceptAllBtn.addEventListener( 'click', function() {
            deleteConsentMode();
            sentConsentAcceptAll();
            hideCookieBanner();
          });
        };
        if (cookieAcceptSelectedBtn){
          cookieAcceptSelectedBtn.addEventListener( 'click', function() {
            deleteConsentMode();
            sentConsentAcceptSelected();
            hideCookieBanner();
          });
        };
        if (cookieRejectAllBtn){
          cookieRejectAllBtn.addEventListener( 'click', function() {
            deleteConsentMode();
            sentConsentRejectAll();
            hideCookieBanner();
          });
        };
      };

      // this is the function to actually set the consent
      // in this function I also assign each consent to a specific label (necessary, marketing, etc.)
      function setConsent(consent) {
        const consentMode = {
          'functionality_storage': consent.necessary ? 'granted' : 'denied',
          'security_storage': consent.necessary ? 'granted' : 'denied',
          'ad_storage': consent.marketing ? 'granted' : 'denied',
          'ad_user_data': consent.marketing ? 'granted' : 'denied',
          'ad_personalization': consent.marketing ? 'granted' : 'denied',
          'analytics_storage': consent.analytics ? 'granted' : 'denied',
          'personalization_storage': consent.preferences ? 'granted' : 'denied',
        };
        gtag( 'consent', 'update', consent );
        localStorage.setItem( 'consentMode', JSON.stringify(consentMode) );
        // I need to reload to actually apply cahnges
        location.reload();
      }

      // change cookie preferences (I need to delete localStorage consentMode to allow restoring)
      var showBannerElement = document.getElementById('show-cookie-banner');
      if (showBannerElement){
        showBannerElement.addEventListener( 'click', function(){
          // if already shown close it
          if ( cookieBannerElement.style.display != "none") {
            hideCookieBanner();
          }else{
            showCookieBanner()
          };
        });
      };

      // this allows to change a single consent element value inside consentMode
      function changeSingleConsent( consent_name, new_value ) {
        jsonConsentModeObject = JSON.parse(localStorage.getItem('consentMode'));
        jsonConsentModeObject[consent_name] = new_value;
        localStorage.setItem( 'consentMode', JSON.stringify(jsonConsentModeObject) );
        location.reload();
      };
      </script>

</body>
</html>
```
