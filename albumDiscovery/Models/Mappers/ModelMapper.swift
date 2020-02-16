class ModelMapper<ApiModel, DBModel> {
    func toDatabase(apiModel: ApiModel) -> DBModel? {
        return nil
    }

    func toApi(dbModel: DBModel) -> ApiModel? {
        return nil
    }

    func toDatabaseArray(apiModels: [ApiModel]) -> [DBModel] {
        return apiModels.map({ (model) -> DBModel? in
            self.toDatabase(apiModel: model)
        }).compactMap { $0 }
    }

    func toApiArray(dbModels: [DBModel]) -> [ApiModel] {
        return dbModels.map({ (model) -> ApiModel? in
            self.toApi(dbModel: model)
        }).compactMap { $0 }
    }
}
