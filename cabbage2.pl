symptom(yellow_leaves).
symptom(wilting).
symptom(black_spots).
symptom(holes_in_leaves).
symptom(swollen_roots).
symptom(stunted_growth).

disease(bacterial_wilt).
disease(black_rot).
disease(aphid_infestation).
disease(club_root).


disease_with_symptoms(bacterial_wilt, [yellow_leaves, wilting]).
disease_with_symptoms(black_rot, [yellow_leaves, black_spots]).
disease_with_symptoms(aphid_infestation, [wilting, holes_in_leaves, stunted_growth]).
disease_with_symptoms(club_root, [yellow_leaves, swollen_roots, stunted_growth]).

possible_disease(Disease, Symptoms) :-
    disease_with_symptoms(Disease, DiseaseSymptoms),
    subset(DiseaseSymptoms, Symptoms),
    write('The disease is '), write(Disease), nl.

possible_diseases_for(Symptom, Diseases) :-
    findall(Disease, (disease_with_symptoms(Disease, Symptoms), member(Symptom, Symptoms)), Diseases).

subset([], _).
subset([H | T], List) :-
    member(H, List),
    subset(T, List).

diagnose_cabbage(Disease, Symptoms) :-
    (possible_disease(Disease, Symptoms) ->
        true
    ;   write('No matching disease found for the given symptoms.'), nl,
        write('Possible diseases: '), nl,
        write_possible_diseases(_PossibleDiseases)
    ).

write_possible_diseases([]).
write_possible_diseases([Disease | Rest]) :-
    write('- '), write(Disease), nl,
    write_possible_diseases(Rest).
