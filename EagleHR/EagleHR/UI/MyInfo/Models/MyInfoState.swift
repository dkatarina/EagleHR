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
                if case .success(_) = dataResult {
                    if editableData.fields.allSatisfy({ _, field in !field.value.isEmpty }) &&
                        editableData.fields.contains(
                            where: { fieldId, field in
                                if field.value != data.fields[fieldId]!.value {
                                    true
                                } else {
                                    false
                                }
                            }
                        ) {
                        return true
                    }
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
            if case .failure(let error) = updateInfoResult {
                error
            } else {
                nil
            }
        }
    }
}
