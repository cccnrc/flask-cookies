#!/usr/bin/env bash

ORIGINAL_GTM_TAG='YOUR_GTM_ID'
ORIGINAL_GTM_TAG_NUM=2
COOKIE_HTML_TMP_FILE=/tmp/cookies.html

function wait_key {
  echo -e "     => press \"y\" or \"Y\" to continue with replacement, otherwise installer.sh will terminate automatically after 5 seconds if no key is pressed."
  read -t 5 -n 1 key
  if [[ $key == "y" || $key == "Y" ]]; then
    echo "       => ok, proceding with replacement ..."
    sleep 0.1
  else
    echo "       => Timeout occurred or other key pressed. Aborting installer.sh"
    exit 0
  fi
}


function show_help {
    echo
    echo "usage:  $BASH_SOURCE --gtm-id <YOUR-GTM-ID> --app-dir <flask-app-path>"
    echo
    echo "                     --gtm-id - this is your personal Google Tag Manager ID: https://support.google.com/tagmanager/answer/6103696?hl=en"
    echo "                     --app-dir - this is the complete pathway of your flask app directory"
    echo
}


# Read options and show help if asked
OPTSTRING=":h"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    h)
      show_help
      exit 0
      ;;
  esac
done

# Read command line options
ARGUMENT_LIST=(
    "app-dir"
    "gtm-id"
)

# read arguments
opts=$(getopt \
    --longoptions "$(printf "%s:," "${ARGUMENT_LIST[@]}")" \
    --name "$(basename "$0")" \
    --options "" \
    -- "$@"
)


# echo $opts

eval set --$opts

while true; do
    case "$1" in
    --app-dir)
        shift
        INSTALL_DIR=$1
        ;;
    --gtm-id)
        shift
        GTM_ID=$1
        ;;
      --)
        shift
        break
        ;;
    esac
    shift
done


echo
echo ' ----------------------------------------------------------------------- '
echo ' -------------------> flask-cookies installer v0.01 <------------------- '
echo ' ----------------------------------------------------------------------- '
echo

echo -e " -> passed GTM ID:\t\t\t\t${GTM_ID}"

echo -e " -> flask app directory:\t\t\t${INSTALL_DIR}"
if [ ! -d "${INSTALL_DIR}" ]; then
  echo
  echo -e " => flask app directory NOT FOUND"
  echo -e "   => aborting script"
  echo
  exit 1
fi

STATIC_DIR="${INSTALL_DIR}/static"
TEMPLATES_DIR="${INSTALL_DIR}/templates"
echo -e "   -> looking for static directory in:\t\t${STATIC_DIR}"
if [ ! -d "${STATIC_DIR}" ]; then
  echo
  echo -e "   => static directory NOT FOUND"
  echo -e "     => creating it ..."
  echo
  mkdir -p ${STATIC_DIR}
fi
sleep 0.2
echo -e "   -> looking for templates directory in:\t${TEMPLATES_DIR}"
if [ ! -d "${TEMPLATES_DIR}" ]; then
  echo
  echo -e "   => templates directory NOT FOUND"
  echo -e "     => creating it ..."
  echo
  mkdir -p ${TEMPLATES_DIR}
fi
sleep 0.2

### if final files already exists ask user if sure to replace
FINAL_COOKIE_HTML_FILE="${TEMPLATES_DIR}/cookies.html"
FINAL_COOKIE_CSS_FILE="${STATIC_DIR}/cookies.css"
FINAL_COOKIE_LOGO_FILE="${STATIC_DIR}/cookies-logo.png"
if [ -f "${FINAL_COOKIE_HTML_FILE}" ]; then
  echo -e "  ==> a file called \"cookies.html\" is already in your app templates dir, you sure you want to replace it?"
  wait_key
fi
if [ -f "${FINAL_COOKIE_CSS_FILE}" ]; then
  echo -e "  ==> a file called \"cookies.css\" is already in your app static dir, you sure you want to replace it?"
  wait_key
fi
if [ -f "${FINAL_COOKIE_LOGO_FILE}" ]; then
  echo -e "  ==> a file called \"cookies-logo.png\" is already in your app static dir, you sure you want to replace it?"
  wait_key
fi



### get cookies.css file full path
DIR0=$( dirname $BASH_SOURCE )
COOKIE_CSS_FILE="${DIR0}/cookies.css"
if [ ! -f "${COOKIE_CSS_FILE}" ]; then
  echo
  echo -e "   => \"cookies.css\" NOT FOUND, did you move \"installer.sh\"?"
  echo -e "     => aborting script"
  echo
  exit 1
fi
### get cookies.html file full path
COOKIE_HTML_FILE="${DIR0}/cookies.html"
if [ ! -f "${COOKIE_HTML_FILE}" ]; then
  echo
  echo -e "   => \"cookies.html\" NOT FOUND, did you move \"installer.sh\"?"
  echo -e "     => aborting script"
  echo
  exit 1
fi
### get cookies-logo.png file full path
COOKIE_LOGO_FILE="${DIR0}/cookies-logo.png"
if [ ! -f "${COOKIE_LOGO_FILE}" ]; then
  echo
  echo -e "   => \"cookies-logo.png\" NOT FOUND, did you move \"installer.sh\"?"
  echo -e "     => aborting script"
  echo
  exit 1
fi


### check ORIGINAL_GTM_TAG is found the expected number of times in the cookies.html file
NUM_ORIGINAL_TAG=$(grep -o "${ORIGINAL_GTM_TAG}" "${COOKIE_HTML_FILE}" | wc -l | awk '{ print $1 }')
echo -e "     -> ${NUM_ORIGINAL_TAG} \"${ORIGINAL_GTM_TAG}\" found in \"cookies.html\""
if [ ${NUM_ORIGINAL_TAG} -ne ${ORIGINAL_GTM_TAG_NUM} ]; then
  echo
  echo -e "   => \"${ORIGINAL_GTM_TAG}\" NOT FOUND ${ORIGINAL_GTM_TAG_NUM} time in \"cookies.html\""
  echo -e "     => aborting script"
  echo -e "       => please report this problem ..."
  echo
  exit 1
fi

### replace ORIGINAL_GTM_TAG with GTM_ID passed
sed -e "s/${ORIGINAL_GTM_TAG}/${GTM_ID}/g" ${COOKIE_HTML_FILE} > ${COOKIE_HTML_TMP_FILE}
### check everything worked fine
NUM_NEW_TAG=$(grep -o "${GTM_ID}" "${COOKIE_HTML_TMP_FILE}" | wc -l | awk '{ print $1 }')
echo -e "     -> ${NUM_NEW_TAG} \"${GTM_ID}\" found in \"cookies.html\" temporary file"
if [ ${NUM_NEW_TAG} -ne ${ORIGINAL_GTM_TAG_NUM} ]; then
  echo
  echo -e "   => \"${NUM_NEW_TAG}\" NOT FOUND ${ORIGINAL_GTM_TAG_NUM} time in \"cookies.html\" temporary file"
  echo -e "     => aborting script"
  echo -e "       => please report this problem ..."
  echo
  exit 1
fi

### copy modified cookies.html to app templates dir
cp ${COOKIE_HTML_TMP_FILE} ${TEMPLATES_DIR}
### copy cookies.css to app static dir
cp ${COOKIE_CSS_FILE} ${STATIC_DIR}
### copy cookies-logo.png to app static dir
cp ${COOKIE_LOGO_FILE} ${STATIC_DIR}


### check files where copied correctly
FINAL_COOKIE_HTML_FILE="${TEMPLATES_DIR}/cookies.html"
FINAL_COOKIE_CSS_FILE="${STATIC_DIR}/cookies.css"
FINAL_COOKIE_LOGO_FILE="${STATIC_DIR}/cookies-logo.png"
if [ -f "${FINAL_COOKIE_HTML_FILE}" ]; then
  echo -e "       -> \"cookies.html\" correctly copied in flask-app templates dir:\t${FINAL_COOKIE_HTML_FILE}"
else
  echo
  echo -e "   => \"cookies.html\" NOT FOUND in ${TEMPLATES_DIR}"
  echo -e "     => aborting script"
  echo -e "       => please report this problem ..."
  echo
  exit 1
fi
if [ -f "${FINAL_COOKIE_CSS_FILE}" ]; then
  echo -e "       -> \"cookies.css\" correctly copied in flask-app static dir:\t${FINAL_COOKIE_CSS_FILE}"
else
  echo
  echo -e "   => \"cookies.css\" NOT FOUND in ${STATIC_DIR}"
  echo -e "     => aborting script"
  echo -e "       => please report this problem ..."
  echo
  exit 1
fi
if [ -f "${FINAL_COOKIE_LOGO_FILE}" ]; then
  echo -e "       -> \"cookies-logo.png\" correctly copied in flask-app static dir:\t${FINAL_COOKIE_LOGO_FILE}"
else
  echo
  echo -e "   => \"cookies-logo.png\" NOT FOUND in ${STATIC_DIR}"
  echo -e "     => aborting script"
  echo -e "       => please report this problem ..."
  echo
  exit 1
fi



echo
echo "  ===> start enjoy your new cookie banner ;) <=== "
echo


### only for debug
# rm ${FINAL_COOKIE_CSS_FILE}
# rm ${FINAL_COOKIE_HTML_FILE}
# rm ${FINAL_COOKIE_LOGO_FILE}


echo
echo ' ----------------------------------------------------------------------- '
echo
