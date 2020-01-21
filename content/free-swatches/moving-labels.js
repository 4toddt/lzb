var inputs = document.getElementsByClassName('move-label');
for (var i = 0; i < inputs.length; i++) {
    input = inputs[i];
    input.onfocus = function() { this.parentElement.className = 'field-group active'; };
    input.onblur = function() {
        if (this.value == '') {
            this.parentElement.className = 'field-group';
        } else {
            this.parentElement.className = 'field-group filled';
        }
    }
    if (input.value == '') {
        input.parentElement.className = 'field-group';
    } else {
        input.parentElement.className = 'field-group filled';
    }
}