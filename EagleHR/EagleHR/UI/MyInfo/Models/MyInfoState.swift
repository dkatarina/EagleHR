//
// Created by Katarina Dokic
//

import Foundation

extension MyInfoView {
    struct ViewState {
        var dataResult: DataLoadingResult<Data> = .loading {
            didSet {
                if case .success(let data) = dataResult {
                    self.data = data
                    var editableData = Data(fieldIds: FieldId.editableFields)
                    editableData.fields.keys.forEach { fieldId in
                        editableData.fields[fieldId] = self.data.fields[fieldId]
                    }
                    self.editableData = editableData
                }
                isErrorDialogShown = if case .failure(_) = dataResult {
                    true
                } else {
                    false
                }
            }
        }
        var updateInfoResult: ProcessingResult? = nil {
            didSet {
                isErrorDialogShown = if case .failure(_) = updateInfoResult {
                    true
                } else {
                    false
                }
            }
        }

        var data = Data(fieldIds: FieldId.allCases)
        var editableData = Data(fieldIds: FieldId.editableFields)

        var isSaveChangesEnabled: Bool {
            func hasValidPendingEdits() -> Bool {
                do {
                    let emailRegex = try Regex(RegexPattern.email)
                    if case .success(_) = dataResult {
                        if editableData.fields.allSatisfy(
                            { fieldId, field in
                                !field.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty || field.value == data.fields[fieldId]!.value
                            }
                        ) &&
                            editableData.fields.contains(
                                where: { fieldId, field in
                                    if field.value != data.fields[fieldId]!.value {
                                        true
                                    } else {
                                        false
                                    }
                                }
                            ) &&
                            editableData.fields[.emailAddress]!.value.wholeMatch(of: emailRegex) != nil
                        {
                            return true
                        }
                    }
                } catch {
                    return false
                }
                return false
            }

            return !isProgressViewShown && hasValidPendingEdits()
        }

        var isProgressViewShown: Bool {
            if case .loading = dataResult {
                true
            } else if case .processing = updateInfoResult {
                true
            } else {
                false
            }
        }

        var isErrorDialogShown: Bool = false
        var error: DescriptiveError? {
            if case .failure(let error) = dataResult {
                error
            } else if case .failure(let error) = updateInfoResult {
                error
            } else {
                nil
            }
        }

        var isForceLogoutDialogShown: Bool = false
    }
}
