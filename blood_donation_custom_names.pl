/* Blood Donation Knowledge Base */

/* Blood Groups */
blood_group(osman, o_neg).
blood_group(rakib, a_pos).
blood_group(alina, b_pos).
blood_group(tuku, ab_pos).
blood_group(farhan, o_pos).
blood_group(rina, ab_neg).
blood_group(kamal, a_neg).
blood_group(sumi, o_pos).
blood_group(akash, b_pos).
blood_group(nadia, ab_pos).

/* Phone Numbers */
phone_number(osman, '01710000001').
phone_number(rakib, '01710000002').
phone_number(alina, '01710000003').
phone_number(tuku, '01710000004').
phone_number(farhan, '01710000005').
phone_number(rina, '01710000006').
phone_number(kamal, '01710000007').
phone_number(sumi, '01710000008').
phone_number(akash, '01710000009').
phone_number(nadia, '01710000010').

/* Age */
age(osman, 25).  age(rakib, 32).  age(alina, 40).
age(tuku, 20).   age(farhan, 28). age(rina, 35).
age(kamal, 45).  age(sumi, 29).   age(akash, 38).
age(nadia, 27).

/* Weight */
weight(osman, 60).  weight(rakib, 55).  weight(alina, 70).
weight(tuku, 55).   weight(farhan, 80). weight(rina, 65).
weight(kamal, 68).  weight(sumi, 50).   weight(akash, 75).
weight(nadia, 54).

/* Health */
healthy(osman). healthy(rakib). healthy(alina).
healthy(tuku).  healthy(farhan). healthy(rina).
healthy(kamal). healthy(sumi).   healthy(akash).
healthy(nadia).

/* Last Donation Days */
last_donated(osman, 120).
last_donated(rakib, 95).
last_donated(alina, 100).
last_donated(tuku, 91).
last_donated(farhan, 85).
last_donated(rina, 180).
last_donated(kamal, 110).
last_donated(sumi, 140).
last_donated(akash, 150).
last_donated(nadia, 130).

/* Availability */
available(osman). available(rakib). available(alina).
available(tuku).  available(farhan). available(rina).
available(kamal). available(sumi).   available(akash).
available(nadia).

/* Location */
location(osman, dhaka).
location(rakib, dhaka).
location(alina, narayanganj).
location(tuku, chittagong).
location(farhan, dhaka).
location(rina, narayanganj).
location(kamal, dhaka).
location(sumi, narayanganj).
location(akash, dhaka).
location(nadia, chittagong).

/* Blood Compatibility */
can_donate(o_neg, a_pos).
can_donate(o_neg, b_pos).
can_donate(o_neg, ab_pos).
can_donate(o_neg, o_pos).
can_donate(o_pos, a_pos).
can_donate(o_pos, b_pos).
can_donate(o_pos, ab_pos).
can_donate(o_pos, o_pos).
can_donate(a_pos, a_pos).
can_donate(a_pos, ab_pos).
can_donate(a_neg, a_pos).
can_donate(b_pos, b_pos).
can_donate(b_pos, ab_pos).
can_donate(ab_pos, ab_pos).
can_donate(ab_neg, ab_pos).

/* === Eligibility Check === */
eligible_donor(Receiver, Donor) :-
    blood_group(Donor, DBG),
    blood_group(Receiver, RBG),
    can_donate(DBG, RBG),
    age(Donor, A), A >= 18,
    weight(Donor, W), W >= 50,
    healthy(Donor),
    last_donated(Donor, DDays), DDays >= 90,
    available(Donor),
    location(Donor, L),
    location(Receiver, L).

/* === Recursive way to get eligible donors === */

/* Base case: empty donor list gives empty result */

donors_for_recursive([], _, []).

/* Recursive case: donor is eligible and not receiver */

donors_for_recursive([Donor|Rest], Receiver, [Donor|EligibleRest]) :-
    eligible_donor(Receiver, Donor),
    Donor \= Receiver,
    donors_for_recursive(Rest, Receiver, EligibleRest).

/* Recursive case: donor not eligible or is receiver */

donors_for_recursive([Donor|Rest], Receiver, EligibleRest) :-
    (\+ eligible_donor(Receiver, Donor) ; Donor = Receiver),
    donors_for_recursive(Rest, Receiver, EligibleRest).

/* Wrapper predicate to start recursion with all donors */
donors_for(Receiver, List) :-
    findall(D, blood_group(D, _), AllDonors),
    donors_for_recursive(AllDonors, Receiver, List).
