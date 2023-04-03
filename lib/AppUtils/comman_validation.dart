

emailValidation(String? value) {
  if (value!.trim().length == 0) {
    return 'Please enter email';
  } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
    return 'Please enter email';
  } else {
    return null;
  }
}

passwordValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter password';
  }
  // _UserProvider.password.text=value;
  return null;
}

firstNameValidation(String value) {
  if (value.trim().length == 0) {
    return 'Please enter first name';
  } else {
    return null;
  }
}

lastNameValidation(String? value) {
  if (value!.trim().length == 0) {
    return 'Please enter last name';
  } else {
    return null;
  }
}

mobileValidation(String? value) {
  if (value!.length == 0) {
    return 'Please enter phone number';
  } else if (value.length < 10) {
    return 'Please enter valid phone number';
  } else {
    return null;
  }
}

companyNameValidation(String ?value) {
  if (value!.trim().length == 0) {
    return 'Please enter company name';
  } else {
    return null;
  }
}

contactPersonValidation(String value) {
  if (value.trim().length == 0) {
    return 'Please enter contact person';
  } else {
    return null;
  }
}

descriptionValidation(String? value) {
  {
    if (value!.trim().length == 0) {
      return 'Please enter description';
    } else {
      return null;
    }
  }
}
eventFeeValidation(String ? value)
{
  {
    if (value == null || value.isEmpty) {
      return 'Please enter event fee';
    }
    return null;
  }
}

eventspeakerValidation(String ? value)
{
  if (value == null || value.isEmpty) {
    return 'Please enter speakers';
  }
  return null;
}
eventvenuValidation(String ?value)
{
  {
    if (value == null || value.isEmpty) {
      return 'Please enter venue';
    }
    return null;
  }
}
eventNameValidation(String ?value)
{
  {
    if (value == null || value.isEmpty) {
      return 'Please enter event name';
    }
    return null;
  }
}
